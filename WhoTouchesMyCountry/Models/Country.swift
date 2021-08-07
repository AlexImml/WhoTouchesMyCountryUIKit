//
//  Country.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation

struct Country: Decodable, Identifiable {
    var name: String?
    var nativeName: String?
    var area: Double?
    var cioc: String?
    var borders: [String?]
    
    var id = UUID() // for list iteration
    
    // because id is not part of the response, this is required to make the Decodable work (making "id" a constant work as well but produces a warning)
    enum CodingKeys: String, CodingKey {
            case name, nativeName, area, cioc, borders
        }
}
