//
//  ViewController.swift
//  BrewAppAssignment
//
//  Created by pslmacuser on 20/11/21.
//

import UIKit
import Alamofire

/*
 ///# MFHomeViewController : Class will display listing of moview snad provide search functioanlity.
 */

class MFHomeViewController: UIViewController {
    
    ///# Outlet for collection list of movies
    @IBOutlet weak var collectionViewMovies:UICollectionView! {
        didSet {
            collectionViewMovies.collectionViewLayout = createCollectionViewLayout()
        }
    }
    
    ///# variable to store moview list and filtered movie list of of type Movie
    var moviesList:[Movie] = []
    
    ///# view model for the home collection list
    private var homeViewModel:HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateHomeUI()
    }

    ///# Function to update home screen ui
    func updateHomeUI(){
        LoadingView.addLoadingView(viewController: self)
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.bindMoviesViewModelToController = {
         
            self.moviesList = self.homeViewModel.moviesData.moviesList
            self.collectionViewMovies.reloadData()
            LoadingView.removeLoadingView()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = self.collectionViewMovies.indexPath(for: sender as! UICollectionViewCell)
        let vc = segue.destination as! MFDetailViewController
        vc.movie = self.homeViewModel.moviesData.moviesList[index!.row]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
   
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        // Define Item Size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        // Create Item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 0.0, bottom: 10.0, trailing: 0.0)

        // Define Group Size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/3))

        // Create Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)

        // Create Section
        let section = NSCollectionLayoutSection(group: group)

        // Configure Section
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    ///# Functin to delete moview from existing list
    @objc func actionDelete(sender:UIButton) {
        let row = sender.tag
        self.collectionViewMovies.performBatchUpdates {
            self.homeViewModel.moviesData.moviesList.remove(at: row)
            self.collectionViewMovies.deleteItems(at: [IndexPath.init(item: row, section: 0)])
            
        } completion: { status in
            
        }

        
    }
}

//MARK: - COLLECTION VIEW
extension MFHomeViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    ///# filter movie list using search text
    func filterCollection(searchText:String) {
        var filterList:[Movie] = []
        for object in self.homeViewModel.moviesData.moviesList {
            if object.title.lowercased().contains(searchText.lowercased()) {
                filterList.append(object)
            }
        }
        moviesList = filterList
        self.collectionViewMovies.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = self.moviesList[indexPath.row]
        var identifier = ""
        
        if movie.voteAverage >= 7.0 {
            identifier = "PopularMoviewCell"
            let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PopularMovieCell
            let imgURL = "https://image.tmdb.org/t/p/original" + movie.backdropPath
            ImageLoader.shared.loadImage(from: URL.init(string: imgURL)!).sink(receiveValue: { image in
                popularCell.imgLargerBanner.alpha = 0.0
                popularCell.imgLargerBanner.image = image
                         UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                            popularCell.imgLargerBanner.alpha = 1.0
                        })
            })
            popularCell.movie = movie
            popularCell.btnDelete.addTarget(self, action: #selector(self.actionDelete(sender:)), for: .touchUpInside)
            popularCell.btnDelete.tag = indexPath.row
            return popularCell
        }
        else {
            identifier = "UnpopularMoviewCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! UnpopularMovieCell
            let unpopularCell = cell as! UnpopularMovieCell
            unpopularCell.movie = movie
            unpopularCell.lblTitle.text = movie.originalTitle
            unpopularCell.lblOverview.text = movie.overview
            unpopularCell.collection = self.collectionViewMovies
            
            let imgURL = "https://image.tmdb.org/t/p/w342" + movie.posterPath
            
            ImageLoader.shared.loadImage(from: URL.init(string: imgURL)!).sink(receiveValue: { image in
                unpopularCell.imgPoster.alpha = 0.0
                unpopularCell.imgPoster.image = image
                         UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                            unpopularCell.imgPoster.alpha = 1.0
                        })
            })
            
            unpopularCell.btnDelete.addTarget(self, action: #selector(self.actionDelete(sender:)), for: .touchUpInside)
            unpopularCell.btnDelete.tag = indexPath.row
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width)) // 15 because of paddings
        print("cell width : \(width)")
        return CGSize(width: width, height: 200)
    }
}

//MARK: - SEARCH
extension MFHomeViewController :UISearchBarDelegate{
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            self.filterCollection(searchText: searchBar.text!)
            searchBar.resignFirstResponder()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            self.moviesList = self.homeViewModel.moviesData.moviesList
            self.collectionViewMovies.reloadData()
            searchBar.resignFirstResponder()
        }
    }
}
