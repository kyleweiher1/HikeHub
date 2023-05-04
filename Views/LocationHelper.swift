//
//  LocationHelper.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 4/27/23.
//
import SwiftUI
import CoreLocation
import MapKit

func addParksNearMe(annotations: Binding<[MKPointAnnotation]>) {
    let locationManager = CLLocationManager()
    
    // Check if location services are enabled
    if CLLocationManager.locationServicesEnabled() {
        // Request user authorization for location access
        locationManager.requestWhenInUseAuthorization()
        
        // Get the user's current location
        if let userLocation = locationManager.location?.coordinate {
            // Define a search radius (in meters) for nearby parks
            let searchRadius: CLLocationDistance = 200 * 1609.34 // 200 miles to meters
            
            // Create a map region centered around the user's location with the search radius
            let coordinateRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: searchRadius, longitudinalMeters: searchRadius)
            
            // Create a local search request to search for nearby park locations
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Park"
            request.region = coordinateRegion
            
            // Perform the local search
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let response = response, error == nil else {
                    print("Error searching for nearby parks: \(error?.localizedDescription ?? "")")
                    return
                }
                
                // Get the park annotations from the search response
                let parkAnnotations = response.mapItems.map { item -> MKPointAnnotation in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.placemark.title
                    return annotation
                }
                
                // Assign the park annotations to the `annotations` property
                annotations.wrappedValue = parkAnnotations
            }
        }
    }
}
struct LocationHelper_Previews: PreviewProvider {
    @State static var annotations: [MKPointAnnotation] = []
    
    static var previews: some View {
        Button(action: {
            addParksNearMe(annotations: $annotations)
        }) {
            Text("Add Parks Near Me")
        }
    }
}
