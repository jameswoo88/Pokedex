//
//  PokeTeamTableViewController.swift
//  Pokedex
//
//  Created by James Chun on 5/4/21.
//

import UIKit

class PokeTeamTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad on PokeTeamTableViewController")
        TeamPokemonController.sharedInstance.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillAppear on PokeTeamTableViewController")

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TeamPokemonController.sharedInstance.teamPokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamTableViewCell,
              !TeamPokemonController.sharedInstance.teamPokemons.isEmpty else { return UITableViewCell() }
                
        let pokemon = TeamPokemonController.sharedInstance.teamPokemons[indexPath.row]
        
        cell.teamPokemon = pokemon
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let teamPokemon = TeamPokemonController.sharedInstance.teamPokemons[indexPath.row]
            TeamPokemonController.sharedInstance.delete(teamPokemon: teamPokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 12
    }
    
}//End of class
