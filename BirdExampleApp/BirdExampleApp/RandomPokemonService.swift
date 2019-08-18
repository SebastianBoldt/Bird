//
//  Datasource.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 18.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import Bird
import Foundation
import Combine

class RandomPokemonService: ObservableObject {
    @Published var currentPokemon: String = ""
    
    private let requestService = Bird.makeRequestService()
    private var subscription: AnyCancellable?

    func requestRandomPokemon() {
        let number = Array(1...150).randomElement() ?? 1
        let request = try! requestService.request(GetPokemon(pokedexNumber: number), responseType: Pokemon.self)
        subscription = request.receive(on: RunLoop.main).sink(receiveCompletion: { [weak self] completion in
            switch completion {
                case .finished:
                    print("Subscription finished")
                case .failure:
                    self?.currentPokemon = ""

            }
        }, receiveValue: { pokemon in
            self.currentPokemon = pokemon.name ?? ""
        })
    }
}
