//
//  NoteModel.swift
//  Board
//
//  Created by 조영민 on 9/30/24.
//

import Foundation
import RealityKit

class NoteModel {
    var entity: Entity?
    var content: String = "Hello"
    var id: UUID = UUID()
    
    init (content: String) {
        self.content = content
        
        var material = SimpleMaterial(color: .yellow, isMetallic: false)
        material.metallic = 0
        material.roughness = 1
        self.entity = ModelEntity(mesh: .generateBox(size: .init(0.1, 0.1, 0.001)), materials: [material])
    }
}
