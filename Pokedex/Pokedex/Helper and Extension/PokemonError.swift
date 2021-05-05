//
//  PokemonError.swift
//  Pokedex
//
//  Created by James Chun on 5/4/21.
//

import UIKit

enum PokemonError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case duplicatePokemon
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
            
        case .thrownError(let error):
            print(error.localizedDescription)
            return "That pokemon does not exist\nPlease check your spelling"
            
        case .noData:
            return "The server responded with no data"
            
        case .unableToDecode:
            return "The server responded with bad data. Blame the back end team, not the front end"
            
        case .duplicatePokemon:
            return "You already have this pokemon. Catch another."
        }
    }
    
}//End of enum
