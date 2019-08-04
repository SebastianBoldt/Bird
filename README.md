![Bird](https://github.com/SebastianBoldt/Bird/blob/develop/Bird/Github/Header.jpg?raw=true)

# 🐤 Bird
### A lightweight networking abstraction layer based on combine

Bird is a lightweight networking abstraction layer for NSURLSession based on Combine.

It provides an easy to use plugin system for logging, intercepting or even retrying requests.
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
    var responseType: Codable.self {
        // Currently just an Idea
    }
    
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

## Plugin Architecture

* shouldRequest
* requestWillBeSent
* requestDidSent
* requestFailed
* requestSucceeded

Feat
* Logging
* Stubbing
* Intercepting Requests
