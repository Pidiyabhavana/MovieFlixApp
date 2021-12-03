//
//  HomeViewModel.swift
//  MovieFlixApp
//
//  Created by pslmacuser on 20/11/21.
//

import Foundation

class HomeViewModel: NSObject {
    
    var bindMoviesViewModelToController : (() -> ()) = {}
    
    private var apiService:APIService!
    var moviesData:MoviesDataModel! {
        didSet {
            self.bindMoviesViewModelToController()
        }
    }
    
    override init() {
        super.init()
        apiService = APIService()
        getMovieList()
    }
    
    func getMovieList(){
        apiService.getMovieList { movies in
            if movies != nil {
                self.moviesData = movies
            }
            
        }
    }
}
