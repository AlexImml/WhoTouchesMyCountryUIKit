//
//  NetworkRequest.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation

enum NetworkRequestError : Error, LocalizedError {
    case noDataError
    case parseDataError
    case badRequest
    case systemError(err : Error)
    
    var errorDescription: String? {
        switch self {
        case .noDataError:              return "no data received"
        case .parseDataError:           return "cant parse data"
        case .badRequest:               return "something wrong with the request (probably the url is bad)"
        case .systemError(let error):   return error.localizedDescription
        }
    }
}

protocol NetworkRequest : AnyObject {
    associatedtype modelType
    var session : URLSession { get set }
    func decode(_ data : Data) -> modelType?
    func execute(withCompletion completion : @escaping (Result<modelType, NetworkRequestError>) -> Void)
}


extension NetworkRequest {
    
    func load(_ request : URLRequest?,session : URLSession ,withCompletion completion : @escaping (Result<modelType, NetworkRequestError>) -> Void) {
        
        // unwrap request
        guard let request = request else { completion(.failure(.badRequest)) ; return }

        // perform the request
        session.dataTask(with: request) { [weak self] (data, response, error) in
            // check error
            
//            let str = String(decoding: data!, as: UTF8.self)
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(.systemError(err: error))) }
                return
            }
            // check data and response
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(.noDataError)) }
                return
            }
            
            // decode and return
            guard let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(.failure(.parseDataError)) }
                return
            }
            
            DispatchQueue.main.async { completion(.success(value)) }
            
        }.resume()
    }
}




