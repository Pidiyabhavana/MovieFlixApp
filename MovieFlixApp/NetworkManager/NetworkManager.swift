//
//  NetworkManager.swift
//  MovieFlixApp
//
//  Created by pslmacuser on 20/11/21.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    func getDataFrom(urlString:String, completionHandler:@escaping (AFDataResponse<Any>, Int, Error?) -> () =  { _, _, _  in })
       {
          
        let requestParameter = ["api_key":ApiEndpoints.apiKey]
        AF.request(urlString, method: .get, parameters: requestParameter, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
            var statusCode = response.response?.statusCode
            if statusCode == nil {
                statusCode = 200
            }
               switch(response.result) {
               case .success(_):
                   completionHandler(response,statusCode!,nil)
                   break
                   
               case .failure(let error):
                   completionHandler(response,statusCode!,error)
               }
           }
       }
    
}
