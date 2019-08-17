import Foundation

protocol RequestConverterProtocol {
    func convertRequest(request: Request) throws -> URLRequest
}

final class RequestConverter: RequestConverterProtocol {
    public func convertRequest(request: Request) throws -> URLRequest {
        guard let url = try makeURL(from: request) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let requestWithParamters = try attachParameters(from: request, to: urlRequest)
        return requestWithParamters
    }
}

extension RequestConverter {
    private func makeURL(from request: Request) throws -> URL? {
        guard var components = URLComponents(string: request.url.absoluteString) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        components.scheme = request.scheme.stringValue
        components.path = request.path
        return components.url
    }
    
    private func attachParameters(from request: Request, to urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        switch request.requestType {
            case .plain:
                return urlRequest
            case .data(let data):
                urlRequest.httpBody = data
            case .jsonEncodable(let encodable):
                try addJSONEncodedBody(encodable: encodable, to: urlRequest)
            default:()
        }
        
        return urlRequest
    }
}

extension RequestConverter {
    func addJSONEncodedBody(encodable: Encodable,
                            encoder: JSONEncoder = JSONEncoder(),
                            to urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        let anyEncodable = AnyEncodable(encodable: encodable)
        urlRequest.httpBody = try encoder.encode(anyEncodable)

        let contentTypeHeaderName = HTTPConstants.Header.Keys.contentType
        if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
            urlRequest.setValue(HTTPConstants.Header.Values.ContentType.applicationJSON,
                                forHTTPHeaderField: contentTypeHeaderName)
        }
        
        return urlRequest
    }
}

/**
 public func urlRequest() throws -> URLRequest {
     guard let requestURL = Foundation.URL(string: url) else {
         throw MoyaError.requestMapping(url)
     }

     var request = URLRequest(url: requestURL)
     request.httpMethod = method.rawValue
     request.allHTTPHeaderFields = httpHeaderFields

     switch task {
     case .requestPlain, .uploadFile, .uploadMultipart, .downloadDestination:
         return request
     case .requestData(let data):
         request.httpBody = data
         return request
     case let .requestJSONEncodable(encodable):
         return try request.encoded(encodable: encodable)
     case let .requestCustomJSONEncodable(encodable, encoder: encoder):
         return try request.encoded(encodable: encodable, encoder: encoder)
     case let .requestParameters(parameters, parameterEncoding):
         return try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)
     case let .uploadCompositeMultipart(_, urlParameters):
         let parameterEncoding = URLEncoding(destination: .queryString)
         return try request.encoded(parameters: urlParameters, parameterEncoding: parameterEncoding)
     case let .downloadParameters(parameters, parameterEncoding, _):
         return try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)
     case let .requestCompositeData(bodyData: bodyData, urlParameters: urlParameters):
         request.httpBody = bodyData
         let parameterEncoding = URLEncoding(destination: .queryString)
         return try request.encoded(parameters: urlParameters, parameterEncoding: parameterEncoding)
     case let .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: bodyParameterEncoding, urlParameters: urlParameters):
         if let bodyParameterEncoding = bodyParameterEncoding as? URLEncoding, bodyParameterEncoding.destination != .httpBody {
             fatalError("Only URLEncoding that `bodyEncoding` accepts is URLEncoding.httpBody. Others like `default`, `queryString` or `methodDependent` are prohibited - if you want to use them, add your parameters to `urlParameters` instead.")
         }
         let bodyfulRequest = try request.encoded(parameters: bodyParameters, parameterEncoding: bodyParameterEncoding)
         let urlEncoding = URLEncoding(destination: .queryString)
         return try bodyfulRequest.encoded(parameters: urlParameters, parameterEncoding: urlEncoding)
     }
 }
 */
