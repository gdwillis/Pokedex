//
//  PokeCell.swift
//  Pokedex
//
//  Created by admin on 10/10/16.
//  Copyright © 2016 gdw. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    required init?(coder aDecoder:NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(pokemon.pokeDexID)")
    }
}
