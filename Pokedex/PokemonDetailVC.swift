//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Simon Zhen on 4/22/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokeInfo: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var pokemonIMG: UIImageView!
    @IBOutlet weak var nextEvoIMG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.id)")
        pokemonIMG.image = img
        
        
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        nameLabel.text = pokemon.name
        pokeInfo.text = pokemon.desc
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        weightLabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        pokedexLabel.text = "\(pokemon.id)"
        typeLabel.text = pokemon.type
        
        
        
        if pokemon.nextEvoID == "" {
            evoLabel.text = "No Evolutions"
            nextEvoIMG.isHidden = true
        }
        else {
            nextEvoIMG.isHidden = false
            nextEvoIMG.image = UIImage(named: pokemon.nextEvoID)
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            evoLabel.text = str
            
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  

}
