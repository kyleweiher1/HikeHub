//
//  ButtonView.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 3/3/23.
//

import SwiftUI
import MapKit

struct ButtonView: View {
    @Binding var annotations: [MKPointAnnotation]

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            HStack {
                Button(action: {
                    addParksNearMe(annotations: $annotations)
                }) {
                    Text("Parks Near Me")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                }
                .buttonStyle(PlainButtonStyle())

                NavigationLink(destination: ListView()) {
                    Text("Saved Trails")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                }
            }
        }
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(annotations: .constant([]))
    }
}

