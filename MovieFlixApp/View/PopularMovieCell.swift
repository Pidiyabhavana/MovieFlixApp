//
//  PopularMovieCell.swift
//  MovieFlixApp
//
//  Created by pslmacuser on 20/11/21.
//

import UIKit

class PopularMovieCell: BaseCollectionViewCell {
    @IBOutlet weak var imgLargerBanner:UIImageView!
    @IBOutlet weak var btnDelete:UIButton!
    
    var movie:Movie!
    @IBAction func actionDelete(sender:UIButton) {
        
    }
}
