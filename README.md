![Bird](https://github.com/SebastianBoldt/Bird/blob/develop/Bird/Github/Header.jpg?raw=true)

# 🐤 Bird

Bird is a lightweight HTTP networking library written in Swift based on Combine focued on maintain- and extendability.

## How to

### Step 1: Create a Request

The first thing you need to create is an Object that conforms to the `RequestDefinition`-Protocol.
This can be a struct, enum or class. It will provide all relevant values for making an actual HTTP-request.

In this Example we create a `RequestDefinition`  
for an Endpoint of the `PokeAPI` that returns a Pokemon by its Pokdex-Number:

```
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
```

### Step 2: Create a Model

Create the expected Model that will be returned by the Server. 
It has to be ``Codable``.

```
struct Pokemon: Codable {
    var name: String?
}
```

### Step 3: Instantiate a RequestService

After the Model was declared you need to create an Instance of Type: ```RequestService```
You can do that by calling a static function on the class ``Bird``.

```
let requestService = Bird.makeRequestService()
```

### Step 4: Making the Request

Because Bird is using ``Combine`` semantics you will be familiar with the following lines of code.
Just sink and go to receive the response you requested.

```
let defition = GetPokemon(pokedexNumber: 3)
let request = try! requestService.request(defintion, responseType: Pokemon.self)
subscription = request.receive(on: RunLoop.main).sink(receiveCompletion: { completion in
    switch completion {
        case .finished:
            // Handle Finished Subscription
        case .failure(let error):
            // Handle Failure
    }
}, receiveValue: { pokemon in
    // Handle Success
})
```

## Plugins

Plugins can be used to prepare, log or even manipulate responses
Currenty a Plugin supports 3 different Types of interception.

* prepare
* willSend
* didReceive

## Coming Soon

* Stubbing
* nested URL Parameters
