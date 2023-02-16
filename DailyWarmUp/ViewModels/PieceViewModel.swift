//
//  PieceViewModel.swift
//  DailyWarmUp
//
//  Created by Workspace on 16/02/23.
//

import Foundation
import RealmSwift

struct PieceViewModel {
    
    func save(_ topic: Topic, _ text: String, _ image: Data) {
        let piece = Piece()
        piece.text = text
        piece.image = image
        guard let thawedObj = topic.thaw() else { return }
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedObj.pieces.append(piece)
            }
        } catch let error {
            print(error)
        }
    }
    
    func delete(_ piece: Piece) {
        guard let thawedObj = piece.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedRealm.delete(thawedObj)
            }
        } catch let error {
            print(error)
        }
    }
}
