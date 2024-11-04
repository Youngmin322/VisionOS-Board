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
    var dragStartPosition: SIMD3<Float> = .zero
    var isDragging: Bool = false
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
    
    mutating public func onChanged(value: EntityTargetValue<DragGesture.Value>) {
        guard canDrag else { return }
        
        let state = GestureComponent.shared
        if state.targetEntity == nil {
            state.targetEntity = value.entity.id
        }
        
        handleDrag(value: value)
    }
    
    mutating private func handleDrag(value: EntityTargetValue<DragGesture.Value>) {
        let state = GestureComponent.shared
        
        if !state.isDragging {
            state.isDragging = true
            state.dragStartPosition = value.entity.scenePosition
        }
        
        let translation3D = value.convert(value.gestureValue.translation3D, from: .local, to: .scene)
        
        let offset = SIMD3<Float>(x: Float(translation3D.x), y: Float(translation3D.y), z: 0) // z축으로 Drag를 하게 되면 게시판을 벗어나므로(앞뒤로) 0으로 지정
        
        let newPosition = state.dragStartPosition + offset
        
        value.entity.scenePosition = newPosition.clamped(lowerBound: [-0.5, -0.31, -.infinity], upperBound: [0.4, 0.2, .infinity])
    }
    
    mutating public func onEnded(value: EntityTargetValue<DragGesture.Value>) {
        let state = GestureComponent.shared
        state.isDragging = false
        state.targetEntity = nil
    }
}

