//
//  TeamPokemonController.swift
//  Pokedex
//
//  Created by James Chun on 5/5/21.
//

import Foundation

class TeamPokemonController {
    //MARK: - Shared
    static var sharedInstance = TeamPokemonController()
    
    //MARK: - SOT
    var teamPokemons: [TeamPokemon] = []
    var imageData: Data?
    
    //MARK: - Functions
    //CRUD functions
    func catchAndAddToTeam(pokemon: Pokemon) {
        guard let imageData = imageData else { return }
        let name = pokemon.name
        let id = pokemon.id
        
        let teamPokemon = TeamPokemon(name: name, id: id, imageData: imageData)
        teamPokemons.append(teamPokemon)
        saveToPersistenceStore()
    }
    
    func delete(teamPokemon: TeamPokemon) {
        guard let index = teamPokemons.firstIndex(of: teamPokemon) else { return }
        teamPokemons.remove(at: index)
        saveToPersistenceStore()
    }
    
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Pokedex.json")
        
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(teamPokemons)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            teamPokemons = try JSONDecoder().decode([TeamPokemon].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    

}//End of class
