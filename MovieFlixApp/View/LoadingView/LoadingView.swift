//
//  LoadingView.swift
//  MovieFlixApp
//
//  Created by pslmacuser on 25/11/21.
//

import UIKit

class LoadingView: UIView {

    static let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: [:])?.first as! LoadingView
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static func addLoadingView(viewController:UIViewController) {
        loadingView.frame = CGRect.init(x: 0.0, y: 0.0, width: viewController.view.frame.size.width, height: viewController.view.frame.size.width)
        viewController.view.addSubview(loadingView)
    }

    static func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
}
