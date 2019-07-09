/**
    Public Interface for the Bird Framework
 */
public struct Bird {
    public static func makeRequestService() -> RequestServiceProtocol {
        let requestConverter = RequestConverter()
        let requestService = RequestService(converter: requestConverter)
        return requestService
    }
}
