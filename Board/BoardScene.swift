//
//  BoardScene.swift
//  Board
//
//  Created by 조영민 on 9/30/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct BoardScene: View {
    @Bindable var boardModel: BoardModel = BoardModel()
    var body: some View {
        Text("Spaital Board")
            .font(.extraLargeTitle)
        
        HStack {
            RealityView { content, _ in
                if let boardEntity = boardModel.entity {
                    content.add(boardEntity)
                }
            } update: { content, attachments in
                for note in boardModel.noteList.values {
                    if let noteEntity = note.entity {
                        boardModel.entity?.addChild(noteEntity)
                    }
                    
                    if let noteAttach = attachments.entity(for: note.id),
                       let noteEntity = note.entity {
                        noteEntity.addChild(noteAttach)
                        noteAttach.setPosition(.init(0.0, 0.0, 0.001),
                                               relativeTo: noteEntity)
                    }
                }
            } attachments: {
                ForEach(Array($boardModel.noteList.values), id: \.id) { $note in
                    Attachment(id: note.id) {
                        NoteView(content: $note.content)
                    }
                }
            }
            .installAllGestures()
            
            VStack {
                Button("Add Note", systemImage: "plus") {
                    let newNote = NoteModel(content: "new Note")
                    boardModel.addNote(newNote)
                }
                Spacer()
            }
        }
    }
}

#Preview(windowStyle: .volumetric, traits: .fixedLayout(width: 1800, height: 1300, depth: 400)) {
    BoardScene()
}
