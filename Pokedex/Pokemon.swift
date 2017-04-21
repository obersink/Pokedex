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
    
    var id: Int { return _id }
    var name: String { return _name }
    
    init(name: String, id: Int) {
        self._id = id
        self._name = name
    }
}
