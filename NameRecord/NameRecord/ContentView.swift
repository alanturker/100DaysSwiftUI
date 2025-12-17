//
//  ContentView.swift
//  NameRecord
//
//  Created by Turker Alan on 17.12.2025.
//

import SwiftUI
import PhotosUI
import CoreLocation

struct RecordedFace: Identifiable, Comparable, Codable, Hashable {
    static func < (lhs: RecordedFace, rhs: RecordedFace) -> Bool {
        lhs.name < rhs.name
    }
    
    var id: UUID = UUID()
    var imageData: Data
    var name: String
    var latitude: Double
    var longitude: Double
    
    var image: Image {
        if let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "placeHolder")
        }
    }
}

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.recordedFaceArray.sorted()) { recordedFace in
                    NavigationLink(value: recordedFace) {
                        HStack {
                            recordedFace.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(recordedFace.name)
                        }
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationDestination(for: RecordedFace.self, destination: { recorded in
                DetailView(recorded: recorded)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                        Image(systemName: "plus")
                    }
                }
            })
            .navigationTitle("RecordFace")
            .onChange(of: viewModel.photosPickerItem) {
                Task {
                    if let loaded = try? await viewModel.photosPickerItem?.loadTransferable(type: Data.self) {
                        viewModel.selectedImageData = loaded
                        viewModel.showAlert = true
                    } else {
                        print("Failed")
                    }
                }
            }
            .alert(
                Text("Enter a name to save"),
                isPresented: $viewModel.showAlert
            ) {
                Button("Cancel", role: .cancel) {
                    viewModel.clearState()
                }
                
                Button("OK") {
                    if let location = locationFetcher.lastKnownLocation {
                        viewModel.addFace(location: location)
                    }
                }
                .disabled(viewModel.name.trimmingCharacters(in: .whitespaces) == "")
                
                TextField("Enter a name", text: $viewModel.name)
                    .textContentType(.name)
            } message: {
                Text("Please enter you pin.")
            }
        }
        .onAppear {
            locationFetcher.start()
        }
    }

}

#Preview {
    ContentView()
}

//MARK: - ViewModel
extension ContentView {
    @Observable
    class ViewModel {
        var recordedFaceArray: [RecordedFace] = [] {
            didSet {
                save()
            }
        }
        var selectedImageData: Data?
        var photosPickerItem: PhotosPickerItem?
        var showPicker: Bool = false
        var showAlert: Bool = false
        var name: String = ""
        
        init() {
            if let decoded = UserDefaults.standard.data(forKey: "recordedFaceArray"),
               let recordedFaceArray = try? JSONDecoder().decode([RecordedFace].self, from: decoded)
            {
                self.recordedFaceArray = recordedFaceArray
            } else {
                self.recordedFaceArray = []
            }
        }
        
        func addFace(location: CLLocationCoordinate2D) {
            if let selectedImageData, !name.isEmpty {
                let recordedFace = RecordedFace(imageData: selectedImageData, name: name, latitude: location.latitude, longitude: location.longitude)
                
                recordedFaceArray.append(recordedFace)
            }
            clearState()
        }
        
        func clearState() {
            name = ""
            selectedImageData = nil
        }
        
        func save() {
            if let data = try? JSONEncoder().encode(recordedFaceArray) {
                UserDefaults.standard.set(data, forKey: "recordedFaceArray")
            }
        }
        
        func delete(offset: IndexSet) {
            recordedFaceArray.remove(atOffsets: offset)
        }
    }
}
