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
    
    private var _nextEvoID: String!
    private var _nextEvoName: String!
    private var _nextEvoLevel: String!
    
    private var _pokemonURL: String!
    
    var id: Int { return _id }
    var name: String { return _name }
    
    var desc: String { return _description == nil ? "" : _description }
    var height: String { return _height == nil ? "" : _height }
    var weight: String { return _weight == nil ? "" : _weight }
    var attack: String { return _attack == nil ? "" : _attack }
    var defense: String { return _defense == nil ? "" : _defense }
    var type: String { return _type == nil ? "" : _type }
    
    var nextEvoID: String { return _nextEvoID == nil ? "" : _nextEvoID }
    var nextEvoName: String { return _nextEvoName == nil ? "" : _nextEvoName }
    var nextEvoLevel: String { return _nextEvoLevel == nil ? "" : _nextEvoLevel }
    
    
    init(name: String, id: Int) {
        self._id = id
        self._name = name
        self._pokemonURL = "\(URL_BASE)/api/v1/pokemon/\(self.id)"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(self._pokemonURL).responseJSON { response in
            if let dict = response.result.value as? [String: Any] {
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
                
                if let types = dict["types"] as? [[String: String]] , types.count > 0 {
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
                
                if let descriptions = dict["descriptions"] as? [[String: String]] {
                    if let descriptionURL = descriptions[0]["resource_uri"] {
                        Alamofire.request("\(URL_BASE)\(descriptionURL)").responseJSON { response in
                            if let descJSON = response.result.value as? [String: Any] {
                                if let desc = descJSON["description"] as? String {
                                    self._description = desc
                                }
                            }
                            completed()
                        }
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [[String: Any]] , evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"] as? Int {
                                    self._nextEvoLevel = "\(lvlExist)"
                                }
                                else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
    class func loadPokemon(completion: @escaping (_ pokemon: [Pokemon]) -> ()) {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        DispatchQueue.global().async {
            do {
                //background
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                var pokemon = [Pokemon]()
                for row in rows {
                    let pokeID = Int(row["id"]!)!
                    let name = row["identifier"]!
                    
                    let poke = Pokemon(name: name, id: pokeID)
                    pokemon.append(poke)
            
                }
                DispatchQueue.main.async {
                    completion(pokemon)
                }
            }
            catch let err as NSError {
                print(err.debugDescription)
            }
        }
    }
}


