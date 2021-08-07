//
//  APIResource.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation

protocol APIResource {
    associatedtype modelType : Decodable
    
    var baseUrl     : String { get }
    var path        : String { get }
    var queryItems  : [URLQueryItem]? { get }
}

extension APIResource {
    
    var url : URL? {
        var component = URLComponents(string: baseUrl)
        component?.path += path
        component?.queryItems = queryItems
        return component?.url
    }
}
