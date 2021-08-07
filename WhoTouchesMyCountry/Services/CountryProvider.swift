//
//  CountryProvider.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation

class CountryProvider {
    
    private let resource = CountriesAllResource()
    private lazy var request = DecodableAPIRequest(resource: resource)
    
    // provide request inside init for fully testable class
    
    func getAllCountries(withCompletion completion : @escaping (Result<[Country], NetworkRequestError>) -> Void) {
        request.execute { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case.success(let countriesArray):
                completion(.success(countriesArray))
            }
        }
    }
    
    
}
