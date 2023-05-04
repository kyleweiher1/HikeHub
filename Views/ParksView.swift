//
//  ParksView.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 4/27/23.
//

import SwiftUI
import MapKit

struct ParksView: View {
    var annotations: [MKPointAnnotation]
    @State private var updatedAnnotations: [MKPointAnnotation] = []
    
    var body: some View {
        NavigationView {
            List(updatedAnnotations, id: \.title) { annotation in
                VStack(alignment: .leading, spacing: 8) {
                    Text(annotation.title ?? "Unknown Park")
                        .font(.headline)
                    Text(annotation.subtitle ?? "Unknown Location")
                        .font(.subheadline)
                }
                .padding()
            }
            .onAppear {
                addParksNearMe(annotations: $updatedAnnotations)
            }
            .navigationTitle("Parks Near Me")
            .navigationBarItems(trailing: Button(action: {
                addParksNearMe(annotations: $updatedAnnotations)
            }) {
                Image(systemName: "arrow.clockwise")
            })
        }
    }
}

struct ParksView_Previews: PreviewProvider {
    static var previews: some View {
        ParksView(annotations: [])
    }
}
