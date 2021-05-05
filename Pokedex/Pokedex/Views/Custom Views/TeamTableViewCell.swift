//
//  TeamTableViewCell.swift
//  Pokedex
//
//  Created by James Chun on 5/4/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    //MARK: - Properties
    var teamPokemon: TeamPokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokeImage: UIImage? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let pokemon = teamPokemon,
              let imageData = teamPokemon?.imageData else { return }
        pokeImageView.image = UIImage(data: imageData)
        pokeNameLabel.text = pokemon.name
        pokeIDLabel.text = String(pokemon.id)
    }
}
