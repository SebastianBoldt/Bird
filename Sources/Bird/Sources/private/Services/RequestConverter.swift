import Foundation

protocol RequestConverterProtocol {
    func convertRequest(request: Request) throws -> URLRequest
}

final class RequestConverter: RequestConverterProtocol {
    public func convertRequest(request: Request) throws -> URLRequest {
        guard var components = URLComponents(string: request.url.absoluteString) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        components.scheme = request.scheme.stringValue
        components.path = request.path
        
        guard let url = components.url else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        // Prepare Headers
        for (key, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        //TODO: Prepare Parameters
        
        return urlRequest
    }
}
