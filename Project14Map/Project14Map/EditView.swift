//
//  Untitled.swift
//  Project14Map
//
//  Created by Turker Alan on 15.12.2025.
//

import SwiftUI
import Observation

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location2) -> Void
    var onDelete: (Location2) -> Void
    
    @State private var viewModel: ViewModel
    
    init(location: Location2,
         onSave: @escaping (Location2) -> Void,
         onDelete: @escaping (Location2) -> Void) {
        self.onSave = onSave
        self.onDelete = onDelete
        
        _viewModel = State(initialValue: ViewModel(location: location))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby…") {
                    nearByView
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newLocation = viewModel.newLocation()
                        onSave(newLocation)
                        dismiss()
                    }
                }
            
                ToolbarItem(placement: .topBarLeading) {
                    Button("Delete", role: .destructive) {
                        let location = viewModel.location
                        onDelete(location)
                        dismiss()
                    }
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

#Preview {
    EditView(location: .example,
             onSave: { _ in },
             onDelete: { _ in })
}
extension EditView {
    @ViewBuilder
    var nearByView: some View {
        switch viewModel.loadingState {
        case .loaded:
            ForEach(viewModel.pages, id: \.pageid) { page in
                let line = Text(page.title).font(.headline) + Text(": ") + Text(page.description).italic()
                line
            }
        case .loading:
            Text("Loading…")
        case .failed:
            Text("Please try again later.")
        }
    }
}

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Observable
    final class ViewModel {
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        @ObservationIgnored var location: Location2
        
        init(location: Location2) {
            self.location = location
            
            name = location.name
            description = location.description
        }
        
        @MainActor
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)

                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }
        
        func newLocation() -> Location2 {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
    }
}
