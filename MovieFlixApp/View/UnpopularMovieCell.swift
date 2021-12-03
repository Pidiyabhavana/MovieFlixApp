//
//  UnpopularMovieCell.swift
//  MovieFlixApp
//
//  Created by pslmacuser on 20/11/21.
//

import UIKit

class UnpopularMovieCell: BaseCollectionViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var imgPoster:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblOverview:UILabel!
    @IBOutlet weak var viewDelete:UIView!
    @IBOutlet weak var deleteWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var btnDelete:UIButton!
    
    var collection:UICollectionView!
    var movie:Movie!
    
    var pan: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
      }
    
    private func commonInit() {
        
    }
    
    @IBAction func actionDelete(sender:UIButton) {
        
    }
}

