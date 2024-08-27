import Foundation

protocol WeatherDataClient {
    func fetchWeatherData(
        cityName: String,
        completion: @escaping (Result<WeatherData, APIError>) -> Void
    )
}

final class DefaultWeatherDataClient: WeatherDataClient {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchWeatherData(
        cityName: String,
        completion: @escaping (Result<WeatherData, APIError>) -> Void
    ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q= \(cityName)&appid=10692b614cde4a27abc3caf08c696dfa&units=metric"

        guard let url = URL(string: url) else {
            completion(.failure(.notExistingURL))
            return
        }

        var request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.invalidStatusCode))
                return
            }

            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200
            else {
                completion(.failure(.invalidStatusCode))
                return
            }

            guard let data else {
                completion(.failure(.decodingFailed))
                return
            }

            do {
                let decodedWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(decodedWeatherData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }
}
