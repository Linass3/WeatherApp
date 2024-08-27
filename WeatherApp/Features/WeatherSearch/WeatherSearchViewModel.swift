import Combine
import Foundation

protocol WeatherSearchViewModel {
    var weatherData: AnyPublisher<WeatherData, Never> { get }
    
    func onSearchButtonDidSelect()
    func onHistoryButtonDidSelect()
    func onSearchTextChange(text: String)
}

final class DefaultWeatherSearchViewModel: WeatherSearchViewModel {
    private let weatherDataSubject = PassthroughSubject<WeatherData, Never>()
    var weatherData: AnyPublisher<WeatherData, Never> {
        weatherDataSubject.eraseToAnyPublisher()
    }
    
    private let weatherDataClient: WeatherDataClient
    
    private var searchCity: String?
    
    init(weatherDataClient: WeatherDataClient) {
        self.weatherDataClient = weatherDataClient
    }
    
    // MARK: - WeatherSearchViewModel
    
    func onSearchButtonDidSelect() {
        guard let searchCity, searchCity != "" else {
            return
        }
        weatherDataClient.fetchWeatherData(cityName: searchCity) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let weatherData):
                weatherDataSubject.send(weatherData)
            case .failure(let apiError):
                print("API error: \(apiError)")
            }
        }
    }
    
    func onHistoryButtonDidSelect() {
        print("history")
    }
    
    func onSearchTextChange(text: String) {
        searchCity = text
    }
}
