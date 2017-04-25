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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
        
    }

  

}
