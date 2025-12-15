//
//  MastodonQuoteApproval.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public struct MastodonQuoteApproval: Codable, Equatable, Hashable, Sendable {
  public enum QuoteAppproveStatus: String, Codable, Sendable {
    case automatic, manual, denied, unknown
  }

  public let currentUser: QuoteAppproveStatus
  public let automatic: [String]
  public let manual: [String]
}
