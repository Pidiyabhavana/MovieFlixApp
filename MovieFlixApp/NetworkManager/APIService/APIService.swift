//
//  APIService.swift
//  MovieFlixApp
//
//  Created by pslmacuser on 20/11/21.
//

import Foundation
import Alamofire

class APIService :  NSObject {
    //https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed

    
    func getMovieList(completion: @escaping (_ moviesData:MoviesDataModel?)->()){
        
        NetworkManager.shared.getDataFrom(urlString: ApiEndpoints.movieListApi) { response, status, error in
            print(response)
            if let jsonData = response.data {
                let jsonDecoder = JSONDecoder()
                let movieData = try! jsonDecoder.decode(MoviesDataModel.self, from:jsonData)
                completion(movieData)
            }
            else {
                completion(nil)
            }
        }
        
       
    }
    
//    func apiToGetEmployeeData(completion : @escaping (Employees) -> ()){
//        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
//            if let data = data {
//
//                let jsonDecoder = JSONDecoder()
//
//                let empData = try! jsonDecoder.decode(Employees.self, from: data)
//                    completion(empData)
//            }
//        }.resume()
//    }
}
