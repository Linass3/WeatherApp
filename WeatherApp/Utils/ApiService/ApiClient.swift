import Foundation

protocol ApiClient {
    func fetchData<T: Codable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void)
}
