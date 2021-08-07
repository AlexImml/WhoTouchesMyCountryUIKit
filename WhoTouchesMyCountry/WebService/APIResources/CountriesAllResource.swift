//
//  CountriesAll.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation

class CountriesAllResource : APIResource {
    
    typealias modelType = [Country]
    
    var baseUrl: String {
        APIConstants.baseUrl
    }
    
    var path: String {
        APIConstants.All
    }

    var queryItems: [URLQueryItem]?
}
