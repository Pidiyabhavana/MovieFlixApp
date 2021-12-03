//
//  Common.swift
//  BrewAppAssignment
//
//  Created by pslmacuser on 20/11/21.
//

import Foundation
struct ConstantsError {
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
}

///# Structure for API Endpoints
struct ApiEndpoints
{
    ///# API key for server
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    ///# base url of server
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    
    ///# API to get movies list from server
    static let movieListApi = baseURL + "now_playing"
    
    ///# API to get trailer list from server
    static let trailerListApi = baseURL + "209112/videos"
}
