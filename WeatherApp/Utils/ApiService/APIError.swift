import Foundation

enum APIError: Error {
    case notExistingURL
    case invalidStatusCode
    case decodingFailed
}
