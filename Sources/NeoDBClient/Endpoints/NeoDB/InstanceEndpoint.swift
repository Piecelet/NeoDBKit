//
//  InstanceEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/23/25.
//

import Foundation

public enum InstanceEndpoint {
    case instance(instance: String? = nil)
    case peers
}

extension InstanceEndpoint: NetworkEndpoint {
    public var host: HostType {
        switch self {
        case .instance(let instance):
            if let instance = instance {
                return .custom(instance)
            } else {
                return .currentInstance
            }
        case .peers:
            return .currentInstance
        }
    }

    public var type: EndpointType {
        .apiV1
    }
    
    public var path: String {
        switch self {
        case .instance: return "/instance"
        case .peers: return "/instance/peers"
        }
    }
}
