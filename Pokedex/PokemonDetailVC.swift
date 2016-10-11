//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by admin on 10/10/16.
//  Copyright © 2016 gdw. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var nextEvolImage: UIImageView!
    @IBOutlet weak var currentEvolImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        
        let image = UIImage(named: "\(pokemon.pokeDexID)")
        mainImage.image = image
        currentEvolImage.image = image
        pokedexLabel.text = "\(pokemon.pokeDexID)"
        
        
        pokemon.downloadPokemonDetail {
            // will only be called after the network call is complete
            print("callback")
       
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.attackLabel.text = self.pokemon.attack
        self.defenseLabel.text = self.pokemon.defense
        self.heightLabel.text = self.pokemon.height
        self.weightLabel.text = self.pokemon.weight
        self.typeLabel.text = self.pokemon.type
        self.descriptionLabel.text = self.pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            nextEvolutionLabel.text = "No Eolutions"
            nextEvolImage.isHidden = true
        }
        else {
            nextEvolImage.isHidden = false
            nextEvolImage.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            nextEvolutionLabel.text = str
            
        }
    }
}
