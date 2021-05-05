//
//  PokemonController.swift
//  Pokedex
//
//  Created by James Chun on 5/4/21.
//

import UIKit

class PokemonController {
    
    //https://pokeapi.co/api/v2/pokemon/4/
    //MARK: - String Contstants
    static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    static let pokemonPathComponent = "pokemon"
        
    //Result<Pokemon, Error> - this means
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        //UTEDD
        //Step 1: Create your URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonPathComponent)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(finalURL) //ALWAY PRINT FINAL URL!!!!
        
        //Step 2: Data Task
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            // Step 3: Error Handling
            if let error = error {
                return completion(.failure(.thrownError(error))) //return is used here because we want to exit the func if we have an error
            }
            
            if let response = response as? HTTPURLResponse {
                print("POKEMON STATUS CODE: \(response.statusCode)")
            }
            
            // Step 4: Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // Step 5: Decode data
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon)) //we don't need to return here becuase no code below this line won't run when we get here
            } catch {
                completion(.failure(.thrownError(error))) //we don't need return here it is the end of the func
            }
        }.resume() //it lets your code run
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        //UTEDD
        //Step 1: Create your URL
        guard let url = pokemon.sprites.classic else { return completion(.failure(.invalidURL)) }
        
        //Step 2: Data Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Step 3: Error Handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("SPRITE STATUS CODE: \(response.statusCode)")
            }
            
            // Step 4: Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            TeamPokemonController.sharedInstance.imageData = data
            
            // Step 5: Decode data
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            completion(.success(sprite))
        }.resume()
    }
    
    static func fetchShinySprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        //UTEDD
        //Step 1: Create your URL
        guard let url = pokemon.sprites.classicShiny else { return completion(.failure(.invalidURL)) }
        
        //Step 2: Data Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Step 3: Error Handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("SHINY SPRITE STATUS CODE: \(response.statusCode)")
            }
            
            // Step 4: Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            TeamPokemonController.sharedInstance.imageData = data
            
            // Step 5: Decode data
            guard let shinySprite = UIImage(data: data) else { return completion(.failure(.unableToDecode)) } //UIImage(data: ) decodes data and turns it into UIImage
            
            completion(.success(shinySprite))
        }.resume()
    }
    
}//End of class

