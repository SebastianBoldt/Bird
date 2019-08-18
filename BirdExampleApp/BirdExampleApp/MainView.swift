//
//  MainView.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 18.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var randomPokemonService: RandomPokemonService
    
    var body: some View {
        VStack {
            Text(randomPokemonService.currentPokemon)
            Button(
                action: {
                    self.randomPokemonService.requestRandomPokemon()
                },
                label: {
                    Text("Request a random Pokemon")
                }
            )
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(RandomPokemonService())
    }
}
#endif
    
