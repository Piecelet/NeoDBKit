import Foundation

/// Lightweight parser for HTTP Link headers (RFC 5988) used by Mastodon pagination.
public struct LinkPagination: Sendable, Equatable {
    public let next: URL?
    public let previous: URL?

    public init(next: URL?, previous: URL?) {
        self.next = next
        self.previous = previous
    }

    public static func parse(from linkHeader: String) -> LinkPagination? {
        let parts = linkHeader.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        var nextURL: URL?
        var prevURL: URL?

        for part in parts {
            // Example: <https://example/api/v1/timelines/home?max_id=123>; rel="next"
            guard let urlStart = part.firstIndex(of: "<"),
                  let urlEnd = part.firstIndex(of: ">"),
                  urlEnd > urlStart
            else { continue }

            let urlString = String(part[part.index(after: urlStart)..<urlEnd])
            guard let url = URL(string: urlString) else { continue }

            if part.contains("rel=\"next\"") {
                nextURL = url
            } else if part.contains("rel=\"prev\"") || part.contains("rel=\"previous\"") {
                prevURL = url
            }
        }

        if nextURL == nil && prevURL == nil {
            return nil
        }
        return LinkPagination(next: nextURL, previous: prevURL)
    }
}
