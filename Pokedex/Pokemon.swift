//
//  Pokemon.swift
//  Pokedex
//
//  Created by Simon Zhen on 4/20/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    private var _id: Int!
    private var _name: String!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _nextEvolutionTxt: String!
    
    private var _pokemonURL: String!
    
    var id: Int { return _id }
    var name: String { return _name }
    
    var desc: String { return _description == nil ? "" : _description }
    var height: String { return _height == nil ? "" : _height }
    var weight: String { return _weight == nil ? "" : _weight }
    var attack: String { return _attack == nil ? "" : _attack }
    var defense: String { return _defense == nil ? "" : _defense }
    var type: String { return _type == nil ? "" : _type }
    
    init(name: String, id: Int) {
        self._id = id
        self._name = name
        self._pokemonURL = "\(URL_BASE)/api/v1/pokemon/\(self.id)"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(self._pokemonURL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let t = types[0]["name"] {
                        self._type = t.capitalized
                    }
                    
                    if types.count > 1 {
                        if let t = types[1]["name"] {
                            self._type! += "/\(t.capitalized)"
                        }
                    }
                }
                else {
                    self._type = ""
                }
                
//                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>] {
//                    if let descriptionURL = descriptions[0]["resource_uri"] {
//                        Alamofire.request("\(URL_BASE)\(descriptionURL)").responseJSON { response in
//                            if let descJSON = response.result.value as? Dictionary<String, AnyObject> {
//                                if let desc = descJSON["description"] as? String {
//                                    self._description = desc
//                                }
//                                
//                            }
//                        }
//                    }
//                }
                //DispatchQueue.main.async {
//                    completed()
                //}
            }
            completed()
        }
    }
}
