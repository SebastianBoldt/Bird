//
//  PokeAPI.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 04.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import Foundation
import Bird

struct PokeAPI: Request {
    var requestType: RequestType = .plain
    
    var scheme: HTTPScheme {
        return .https
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: [String : Codable] {
        return [:]
    }

    var headers: [String : String] {
        return [:]
    }

    var url: URL {
        return URL(string: "https://pokeapi.co")!
    }

    var path: String {
        return "/api/v2/pokemon/ditto"
    }
}
