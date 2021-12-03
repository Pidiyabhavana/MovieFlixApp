//
//  BADetailViewController.swift
//  BrewAppAssignment
//
//  Created by pslmacuser on 20/11/21.
//

import UIKit
import Alamofire

/*
 ///# MFDetailViewController : Class will display rating, large banner and brief information about moview
 
 */
class MFDetailViewController: UIViewController {

    ///# Variable to store moview information
    var movie:Movie!
    
    ///# Outlet to show moview title
    @IBOutlet weak var lblTitle:UILabel!
    
    ///# Outlet to show moview release data
    @IBOutlet weak var lblReleaseDate:UILabel!
    
    ///# Outlet to show moview overview
    @IBOutlet weak var lblOVerview:UILabel!
    
    ///# Outlet to show moview large banner
    @IBOutlet weak var imgPoster:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    ///# Function to update detail screen ui
    func updateUI(){
        lblTitle.text = movie.title
        lblOVerview.text = movie.overview
        lblReleaseDate.text = movie.releaseDate
        
        let imgURL = "https://image.tmdb.org/t/p/original" + movie.backdropPath
        ImageLoader.shared.loadImage(from: URL.init(string: imgURL)!).sink(receiveValue: { image in
            self.imgPoster.alpha = 0.0
            self.imgPoster.image = image
                     UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                        self.imgPoster.alpha = 1.0
                    })
        })
        
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
