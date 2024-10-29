//
//  GestureComponents.swift
//  RealityKitContent
//
//  Created by 조영민 on 10/28/24.
//

import RealityKit
import SwiftUI

class EntityGestureState: Codable {
    var targetEntity: UInt64?
    
}

@MainActor
public struct GestureComponent: Component, Codable {
    var canDrag = true
    var canTap = true
    var isYellow = true
    
    static var shared = EntityGestureState()
    
    mutating public func onEnded(value: EntityTargetValue<TapGesture.Value>) {
        guard canTap else { return }
        
        let state = GestureComponent.shared
        if state.targetEntity == nil {
            state.targetEntity = value.entity.id
        }
        
        handleTap(value: value)
    }
    
    mutating private func handleTap(value: EntityTargetValue<TapGesture.Value>) {
        let entity = value.entity
        
        guard var model = entity.components[ModelComponent.self] else {
            return
        }
        
        if var material = model.materials.first as? SimpleMaterial {
            material.color.tint = isYellow ? .green : .yellow
            self.isYellow = isYellow ? false : true
            model.materials = [material]
            entity.components.set([model, self])
        }
    }
}

