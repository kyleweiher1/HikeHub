//
//  ContentView.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 3/30/23.
//

//
//  ContentView.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 3/30/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isPresentingListView = false
    @State private var isPresentingParksView = false
    @State private var annotations: [MKPointAnnotation] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Welcome to HikeHub!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            SearchView()
            MapView(annotations: $annotations)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isPresentingParksView = true
                }) {
                    Text("Parks Near Me")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                Spacer()
                Button(action: {
                    isPresentingListView = true
                }) {
                    Text("Saved Trails")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.white)
            .sheet(isPresented: $isPresentingListView) {
                NavigationView {
                    ListView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard)
        .alignmentGuide(.bottom) { dimensions in
            return dimensions[.bottom]
        }
        .sheet(isPresented: $isPresentingParksView) {
            ParksView(annotations: annotations)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
