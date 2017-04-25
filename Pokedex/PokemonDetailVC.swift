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
    @IBOutlet weak var pokemonIMG: UIImageView!
    @IBOutlet weak var pokeInfo: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  

}
