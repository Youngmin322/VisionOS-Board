//
//  BoardModel.swift
//  Board
//
//  Created by 조영민 on 9/30/24.
//

import Foundation
import RealityKit
import RealityKitContent

@Observable
class BoardModel {
    var entity: Entity?
    var noteList: [ObjectIdentifier: NoteModel] = [:]
    init() {
        entity = Entity.createBoard()
    }
    
    func addNote(_ note: NoteModel) {
        noteList[note.id] = note
    }
}
