//
//  ViewController.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 04.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import UIKit
import Bird
import Combine
struct Pokemon: Codable {
    var name: String?
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel?
    var subscription: AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let requestService = Bird.makeRequestService()
        let r = PokeAPI()
        let request = try! requestService.request(r, responseType: Pokemon.self)
        subscription = request.receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                    print("Subscription finished")
                    self.label?.text = "success"

                case .failure(let error):
                    print(error.localizedDescription)
                    self.label?.text = error.localizedDescription

            }
        }, receiveValue: { pokemon in
            print(pokemon)
            self.label?.text = pokemon.name
        })
    }


}

