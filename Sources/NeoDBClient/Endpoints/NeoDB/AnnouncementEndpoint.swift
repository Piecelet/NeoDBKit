//
//  AnnouncementEndpoint.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 2/1/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public enum AnnouncementEndpoint {
    case get
}

extension AnnouncementEndpoint: NetworkEndpoint {
    public var type: EndpointType { .apiV1 }
    public var path: String { "/announcements" }
}
