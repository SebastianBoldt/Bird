//
//  PokeAPI.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 04.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import Foundation
import Bird

struct GetPokemon: RequestDefinition {    
    let pokedexNumber: Int
    
    init(pokedexNumber: Int) {
        self.pokedexNumber = pokedexNumber
    }
}

extension GetPokemon {
    var method: HTTPMethod {
        return .get
    }

    var url: String {
        return "pokeapi.co"
    }

    var path: String {
        return "/api/v2/pokemon/\(pokedexNumber)"
    }
}
