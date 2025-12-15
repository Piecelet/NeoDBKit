//
//  MastodonApplication.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public struct MastodonApplication: Codable, Identifiable, Hashable, Equatable, Sendable {
  public var id: String {
      name + (website?.absoluteString ?? "")
  }

  public let name: String
  public let website: URL?
}

extension MastodonApplication {
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    website = try? values.decodeIfPresent(URL.self, forKey: .website)
  }
}
