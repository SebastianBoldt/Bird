![Bird](https://github.com/SebastianBoldt/Bird/blob/develop/Bird/Github/Header.jpg?raw=true)

# 🐤 Bird
### Bird is an HTTP networking library written in Swift based on Combine.

Bird is a lightweight abstraction layer above NSURLSession based on Combine.

## Basic Example

```
let requestService = Bird.makeRequestService()
let request = try! service.request(someRequest, responseType: ACodable.self)
let subscription = request.sink(receiveCompletion: { completion in
    switch completion {
        case .finished:
            print("Subscription finished")
        case .error(let error):
            print(error.localizedDescription)
    }
}, receiveValue: { pokemon in
    print(pokemon)
})
```
## How to use

The first thing you need to create is an Object conforming to the Request Protocol.
This can be a struct, enum or class. It will provide all relevant values for making a http-request.
```

struct PokeAPI: Request {
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
```

## Plugins

* shouldRequest
* requestWillBeSent
* requestDidSent
* requestFailed
* requestSucceeded

## Coming Soon

* Stubbing
* nested URL Parameters
