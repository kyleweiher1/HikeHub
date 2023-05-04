//
//  ViewExtensions.swift
//  HikeHubV2
//
//  Created by Kyle Weiher on 4/27/23.
//

// ViewExtensions.swift

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func onTapGestureToEndEditing() -> some Gesture {
        TapGesture().onEnded { _ in
            endEditing()
        }
    }
}
