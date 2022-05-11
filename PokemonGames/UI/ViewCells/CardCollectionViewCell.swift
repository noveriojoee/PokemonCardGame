//
//  CardCollectionViewCell.swift
//  PokemonGames
//
//  Created by noverio joe on 15/02/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCardImage(image : String){
//        DispatchQueue.main.async {
            self.cardImage.downloaded(from: image)
//        }
        
    }
    
}
