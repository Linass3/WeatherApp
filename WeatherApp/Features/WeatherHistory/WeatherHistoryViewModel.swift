import Foundation

protocol WeatherHistoryViewModel {
    var weatherDataList: [WeatherData] { get }
}

final class DefaultWeatherHistoryViewModel: WeatherHistoryViewModel {
    var weatherDataList: [WeatherData]

    private let weatherHistoryService: WeatherHistoryService

    init(weatherHistoryService: WeatherHistoryService) {
        self.weatherHistoryService = weatherHistoryService
        weatherDataList = weatherHistoryService.getWeatherDataList()
    }
}
