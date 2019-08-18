![Bird](https://github.com/SebastianBoldt/Bird/blob/develop/Bird/Github/Header.jpg?raw=true)

<a href="https://paypal.me/boldtsebastian"><img src="https://img.shields.io/badge/paypal-donate-blue.svg?longCache=true&style=flat-square" alt="current version" /></a>
<a href="https://cocoapods.org/pods/Jelly"><img src="https://img.shields.io/badge/version-0.0.1-green.svg?longCache=true&style=flat-square" alt="current version" /></a>
<a href="http://twitter.com/sebastianboldt"><img src="https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?longCache=true&style=flat-square" alt="twitter handle" /></a>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift5.0-compatible-orange.svg?longCache=true&style=flat-square" alt="Swift 5.0 compatible" /></a>
<a><img src="https://img.shields.io/badge/spm-compatible-green.svg?longCache=true&style=flat-square" alt="SPM Support" /></a>
<a href="https://en.wikipedia.org/wiki/MIT_License"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?longCache=true&style=flat-square" alt="license" /></a>

# 🐤 Bird

Bird is a lightweight HTTP networking library written in Swift. <br />
It is based on Combine and focused on maintain- and extendability.

## How to

### Step 1: Create a Request

The first thing you need to create is an Object that conforms to the `RequestDefinition`-Protocol.<br />
This can be a struct, enum or class. It will provide all relevant values for making an actual HTTP-request.<br />
In this Example we create a `RequestDefinition`<br />
for an Endpoint of the `PokeAPI` that returns a Pokemon by its Pokdex-Number:

```swift
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

Create the expected Model that will be returned by the Server. <br />
It has to be ``Codable``.

```swift
struct Pokemon: Codable {
    var name: String?
}
```

### Step 3: Create a RequestService

After the Model was declared you need to create an Instance of Type: ```RequestService```<br />
You can do that by calling a static function on the class ``Bird``.

```swift
let requestService = Bird.makeRequestService()
```

### Step 4: Make the Request

Because Bird is using ``Combine``  you will be familiar with the semantics and the following lines of code.<br />
Just ``sink`` & go to receive the response you requested.

```swift
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

Plugins can be used to prepare requests or log responses.<br />
Currenty a ``Plugin`` supports 3 different Types of interception.

* prepare
* willSend
* didReceive

```swift
struct ExamplePlugin: Plugin {
    func prepare(request: URLRequest, definition: RequestDefinition) -> URLRequest {
        // Manipulate the request with Authorization Headers etc. 
        return request
    }
    
    func willSend(request: URLRequest, definition: RequestDefinition) {
        // Request will be send in the next Step
    }
    
    func didReceive(result: URLSession.DataTaskPublisher.Output, definition: RequestDefinition) {
        // Request was successfull and will be published to the subscriber
    }
}
```

## Coming Soon

* Stubbing
* PublisherPlugins
* nested URL Parameters
* Plugin-Suite
