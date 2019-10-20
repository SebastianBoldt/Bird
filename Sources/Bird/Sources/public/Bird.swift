//
//  Bird.swift
//
//  Created by Sebastian Boldt on 07.07.19.
//

public struct Bird {
    public static func makeRequestService() -> RequestServiceProtocol {
        let requestConverter = RequestConverter(urlCreator: URLCreator(),
                                                bodyPreparator: BodyPreparator())
        let requestService = RequestService(converter: requestConverter, pluginHandler: PluginHandler())
        return requestService
    }
}
