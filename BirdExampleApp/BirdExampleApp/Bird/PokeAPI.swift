//
//  PokeAPI.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 04.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import Foundation
import Bird

struct PokeAPI: RequestDefinition {    
    var urlParameters: [String : String] {
        return [:]
    }
    
    var bodyParameterType: BodyParameterType? {
        return nil
    }
    
    var plugins: [Plugin] {
        return [ExamplePlugin()]
    }
    
    var scheme: Scheme {
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
