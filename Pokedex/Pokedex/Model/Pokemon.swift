//
//  Pokemon.swift
//  Pokedex
//
//  Created by James Chun on 5/4/21.
//

import Foundation

struct Pokemon: Decodable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    
    struct Sprites: Decodable {
        
        let classic: URL?
        let classicShiny: URL?
        let femaleShiny: URL?
        
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
            case classicShiny = "front_shiny"
            case femaleShiny = "front_shiny_female"
        }
        
    } //End of struct
    
} //End of struct

