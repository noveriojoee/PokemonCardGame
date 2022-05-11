//
//  ActivityIndicatorCollectionViewCell.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import UIKit

class ActivityIndicatorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func setupIndicatorViewCell(){
        self.activityIndicator.startAnimating()
    }

}
