//
//  NetworkLogger.swift
//  NeoDBClient
//
//  Lightweight logging helpers for networking within the NeoDBClient package.
//

import Foundation
import OSLog

public enum NetworkLogger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "app.neodb"

    public static let core = Logger(subsystem: subsystem, category: "network")
    public static let request = Logger(subsystem: subsystem, category: "network.request")
    public static let response = Logger(subsystem: subsystem, category: "network.response")
}
