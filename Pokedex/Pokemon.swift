//
//  Pokemon.swift
//  Pokedex
//
//  Created by admin on 10/10/16.
//  Copyright © 2016 gdw. All rights reserved.
//

import Foundation
import Alamofire 

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    private var _weight: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        
        return _nextEvolutionLevel
    }
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var name: String {
        return _name
    }
    
    var pokeDexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokeDexID)/"
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON{ (response) in
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
            
            if let types = dict["types"] as? [Dictionary<String, String>] ,types.count > 0 {
                //only one type
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                //if more than one type concatinate them
                if types.count > 1 {
                    for x in 1..<types.count {
                        if let name = types[x]["name"] {
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                }
                
            } else {
                self._type = ""
            }
            
            if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>] , descriptionArray.count > 0 {
                if let url = descriptionArray[0]["resource_uri"] {
                    let descriptionURL = "\(URL_BASE)\(url)"
                    Alamofire.request(descriptionURL).responseJSON{ (response) in
                        if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                            if let description = descriptionDict["description"] as? String {
                                //fix Pokemon typo
                                let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                self._description = newDescription
                            }
                        }
                        completed()
                    }
                } else {
                    self._description = ""
                }
            }
            if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                if let nextEvo = evolutions[0]["to"] as? String {
                    if nextEvo.range(of: "mega") == nil {
                        self._nextEvolutionName = nextEvo
                        
                        if let uri = evolutions[0]["resource_uri"] as? String {
                            let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                            self._nextEvolutionId = nextEvoId
                            
                            if let lvlExist = evolutions[0]["level"] {
                                if let lvl = lvlExist as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                            } else {
                                self._nextEvolutionLevel = ""
                            }
                        }
                    }
                }
            }
            }
            
            
       
            completed()
        }
    }
}
