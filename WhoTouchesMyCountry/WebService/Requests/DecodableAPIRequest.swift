//
//  CodableAPIRequest.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation


class DecodableAPIRequest<Resource : APIResource> {
    let resource: Resource
    var session: URLSession

    init(resource: Resource, session: URLSession = URLSession(configuration: .default)) {
        self.resource = resource
        self.session = session
    }
}

extension DecodableAPIRequest : NetworkRequest {
    
    typealias modelType = Resource.modelType

    func decode(_ data: Data) -> Resource.modelType? {
        let decoder = JSONDecoder()
        // configure decode strategies if needed
        let decodedData = try? decoder.decode(modelType.self, from: data)
        return decodedData
    }
    
    func execute(withCompletion completion: @escaping (Result<Resource.modelType, NetworkRequestError>) -> Void) {
        let request = buildRequest()
        load(request,session: session, withCompletion: completion)
    }
    
    private func buildRequest() -> URLRequest? {
        guard let url = resource.url else { return nil }
        return URLRequest(url: url)
    }
}
