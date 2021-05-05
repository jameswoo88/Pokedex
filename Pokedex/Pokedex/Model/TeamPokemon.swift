//
//  TeamPokemon.swift
//  Pokedex
//
//  Created by James Chun on 5/5/21.
//

import UIKit

class TeamPokemon: Codable {
    
    let name: String
    let id: Int
    let imageData: Data
    let uuid: String
    
    init(name: String, id: Int, imageData: Data, uuid: String = UUID().uuidString) {
        self.name = name
        self.id = id
        self.imageData = imageData
        self.uuid = uuid
    }
    
}

extension TeamPokemon: Equatable {
    static func == (lhs: TeamPokemon, rhs: TeamPokemon) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}//End of extension

