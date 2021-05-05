//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by James Chun on 5/4/21.
//

import UIKit

class PokemonViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    
    //MARK: - Properties
    var isShiny: Bool = false
    var pokemon: Pokemon?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TeamPokemonController.sharedInstance.loadFromPersistenceStore()
        pokeSearchBar.delegate = self
    }
    
    //MARK: - Actions
    @IBAction func shinyButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        if isShiny {
            fetchSpriteAndUpdateViews(for: pokemon)
            isShiny.toggle()
        } else {
            fetchShinySpriteAndUpdateViews(for: pokemon)
            isShiny.toggle()
        }
    }
    
    @IBAction func catchButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        TeamPokemonController.sharedInstance.catchAndAddToTeam(pokemon: pokemon)
    }
    
    
    //MARK: - Functions
    func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name
                    self.pokeIDLabel.text = String(pokemon.id)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
    }
    
    func fetchShinySpriteAndUpdateViews(for pokemon: Pokemon) {
        PokemonController.fetchShinySprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let shinySprite):
                    self.pokeImageView.image = shinySprite
                case .failure(let error):
                    self.pokeImageView.image = UIImage(named: "noShiny")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
}//End of class

//MARK: - Extensions
extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchTerm: searchTerm) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                    self.pokemon = pokemon
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    
}//End of extension
