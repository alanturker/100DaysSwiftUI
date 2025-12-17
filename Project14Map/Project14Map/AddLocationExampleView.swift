//
//  AddLocationExampleView.swift
//  Project14Map
//
//  Created by Turker Alan on 14.12.2025.
//

import MapKit
import SwiftUI
import LocalAuthentication

struct Location2: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
#if DEBUG
    static let example = Location2(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
#endif
    
}

struct AddLocationExampleView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                mapView
                VStack(spacing: 2) {
                    Text("Toggle MapStyle")
                    
                    Toggle("", isOn: $viewModel.isHybrid)
                    .labelsHidden()
                    
                    Spacer()
                }
                .frame(width: 100, alignment: .trailing)
            }
            
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(viewModel.mapError?.title ?? "", isPresented: $viewModel.isShowAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.mapError?.message ?? "")
                }
        }
    }
}

#Preview {
    AddLocationExampleView()
}

extension AddLocationExampleView {
    var mapView: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .simultaneousGesture(
                                LongPressGesture(minimumDuration: 0.5)
                                    .onEnded { _ in
                                        viewModel.selectedPlace = location
                                    }
                            )
                    }
                }
            }
            .mapStyle(viewModel.mapStyle)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    viewModel.addLocation(at: coordinate)
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place,
                         onSave: { viewModel.update(location: $0)},
                         onDelete: { viewModel.remove(location: $0)}
                )
            }
        }
    }
}

extension AddLocationExampleView {
    struct MapError {
        let title: String
        let message: String
    }
    @Observable
    class ViewModel {
        private(set) var locations: [Location2]
        var selectedPlace: Location2?
        var mapStyle: MapStyle = .standard
        var isHybrid: Bool = false {
            didSet {
                toggleMapStyle()
            }
        }
        var isUnlocked: Bool = false
        var mapError: MapError?
        var isShowAlert: Bool = false
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location2].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location2(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location2) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func remove(location: Location2) {
            guard let selectedPlace else { return }
            
            locations.removeAll { location in
                location == selectedPlace
            }
            
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                    
                    if success {
                        self?.isUnlocked = true
                    } else {
                        let error = MapError(title: "Can not authenticate", message: "Give phone to the real user to use this feature.")
                        self?.mapError = error
                        self?.isShowAlert = true
                    }
                }
            } else {
                let error = MapError(title: "Biometric not available", message: "Please adde biometric data to your phone to use this feature.")
                mapError = error
                isShowAlert = true
            }
        }
        
        private func toggleMapStyle() {
            self.mapStyle = isHybrid ? .hybrid : .standard
        }
    }
}
