//
//  File.swift
//  RealityKitContent
//
//  Created by 조영민 on 10/30/24.
//

import Foundation
import RealityKit
import SwiftUI

extension Gesture where Value == EntityTargetValue<TapGesture.Value> {
    @MainActor public func useGestureComponent() -> some Gesture {
        onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
        }
    }
}
