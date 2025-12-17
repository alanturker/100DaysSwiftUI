//
//  DetailView.swift
//  NameRecord
//
//  Created by Turker Alan on 17.12.2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct DetailView: View {
    let recorded: RecordedFace
    
    var startPosition: MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: recorded.latitude, longitude: recorded.longitude),
                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )
        )
    }
    
    var body: some View {
        VStack {
            HStack {
                recorded.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                
                Map(initialPosition: startPosition) {
                    Annotation("User LastKnown", coordinate: CLLocationCoordinate2D(latitude: recorded.latitude, longitude: recorded.longitude)) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                    }
                }
                .frame(height: 200)  
            }
            
            Text(recorded.name)
                .font(.headline)
        }
    }
}

#Preview {
    DetailView(recorded: RecordedFace(imageData: Data(), name: "", latitude: 0.0, longitude: 0.0))
}
