//
//  MapView.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 3/30/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    @Binding var annotations: [MKPointAnnotation]
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        locationManager.requestWhenInUseAuthorization()
        
        addParks()
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        let coordinator = MapViewCoordinator(mapView: mapView)
        coordinator.addAnnotationsForPetsData()
        return coordinator
    }
    
    func addParks() {
        let nationalParksRequest = MKLocalSearch.Request()
        nationalParksRequest.naturalLanguageQuery = "National Park"
        nationalParksRequest.region = mapView.region
        let nationalParksSearch = MKLocalSearch(request: nationalParksRequest)
        
        let stateParksRequest = MKLocalSearch.Request()
        stateParksRequest.naturalLanguageQuery = "State Park"
        stateParksRequest.region = mapView.region
        let stateParksSearch = MKLocalSearch(request: stateParksRequest)
        
        let hikingTrailsRequest = MKLocalSearch.Request()
        hikingTrailsRequest.naturalLanguageQuery = "Hiking Trail"
        hikingTrailsRequest.region = mapView.region
        let hikingTrailsSearch = MKLocalSearch(request: hikingTrailsRequest)
        
        let group = DispatchGroup()
        
        group.enter()
        nationalParksSearch.start { response, error in
            defer { group.leave() }
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.subtitle = item.placemark.title
                self.annotations.append(annotation)
            }
        }
        
        group.enter()
        stateParksSearch.start { response, error in
            defer { group.leave() }
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.subtitle = item.placemark.title
                self.annotations.append(annotation)
            }
        }
        
        group.enter()
        hikingTrailsSearch.start { response, error in
            defer { group.leave() }
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.subtitle = item.placemark.title
                self.annotations.append(annotation)
            }
        }
        
        group.notify(queue: .main) {
            // All searches completed
        }
        
        
        // Function to add pet locations from csv to the map
        func addPetsData() {
            if let url = Bundle.main.url(forResource: "PetsData", withExtension: "csv") {
                do {
                    let data = try String(contentsOf: url)
                    let lines = data.components(separatedBy: .newlines)
                    for line in lines {
                        let fields = line.components(separatedBy: ",")
                        if fields.count == 3 {
                            let lat = Double(fields[1])
                            let long = Double(fields[2])
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                            annotation.title = fields[0]
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                } catch {
                    print("Error reading csv file: \(error.localizedDescription)")
                }
            }
        }
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        
        var mapView: MKMapView
        
        init(mapView: MKMapView) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let tileOverlay = overlay as? MKTileOverlay {
                return MKTileOverlayRenderer(tileOverlay: tileOverlay)
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func addAnnotationsForPetsData() {
            // Read data from PetsData CSV file
            guard let filePath = Bundle.main.path(forResource: "PetsData", ofType: "csv") else {
                print("PetsData.csv file not found.")
                return
            }
            
            do {
                let contents = try String(contentsOfFile: filePath, encoding: .utf8)
                let lines = contents.components(separatedBy: .newlines)
                
                for line in lines {
                    let data = line.components(separatedBy: ",")
                    
                    // Check if the data is valid
                    if data.count != 4 {
                        continue
                    }
                    
                    // Parse the data
                    let name = data[0]
                    let latitude = Double(data[1]) ?? 0
                    let longitude = Double(data[2]) ?? 0
                    let notes = data[3]
                    
                    // Add an annotation for the pet location
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    annotation.title = name
                    annotation.subtitle = notes
                    mapView.addAnnotation(annotation)
                }
                
            } catch {
                print("Error reading PetsData.csv file: \(error.localizedDescription)")
            }
        }
    }
}
struct MapView_Previews: PreviewProvider {
        static var previews: some View {
            MapView(annotations: .constant([]))
        }
    }







