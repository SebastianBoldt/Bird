![Bird](https://github.com/SebastianBoldt/Bird/blob/develop/Github/Header.jpg?raw=true)

# 🐤 Bird

Sometimes we just need to make a simple request.
Bird is a lightweight networking abstraction layer for NSURLSession based on Combine.
It provides a simple plugin system for intercepting network requests as well as stubbing out of the box.

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
This can be a struct, enum or class. It will provide all relevant values for making your http request.
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

After you created your Target you

Feat
* Logging
* Stubbing
* Intercepting Requests
