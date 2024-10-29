//
//  RealityViewExtensions.swift
//  RealityKitContent
//
//  Created by 조영민 on 10/30/24.
//

import RealityKit
import SwiftUI

public extension RealityView {
    func installAllGestures() -> some View {
        gesture(tapGesture)
    }
    
    var tapGesture: some Gesture {
        TapGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
}
