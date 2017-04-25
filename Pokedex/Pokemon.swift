//
//  Pokemon.swift
//  Pokedex
//
//  Created by Simon Zhen on 4/20/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation


class Pokemon {
    private var _id: Int!
    private var _name: String!
    private var _description: String!
    private var _type: String!
    private var _pokedexID: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
    var id: Int { return _id }
    var name: String { return _name }
    
    init(name: String, id: Int) {
        self._id = id
        self._name = name
    }
}
