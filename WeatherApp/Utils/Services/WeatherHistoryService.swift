import Foundation

protocol WeatherHistoryService {
    func saveWeatherData(weatherData: WeatherData)
    func getWeatherDataList() -> [WeatherData]
}

final class DefaultWeatherHistoryService: WeatherHistoryService {
    private let key: String = "weatherDataList"

    // MARK: - WeatherHistoryService

    func saveWeatherData(weatherData: WeatherData) {
        var cachedWeatherDataList = getWeatherDataList()

        cachedWeatherDataList.insert(weatherData, at: 0)
        if cachedWeatherDataList.count > 5 {
            cachedWeatherDataList.removeLast()
        }

        saveWeatherDataList(cachedWeatherDataList)
    }

    func getWeatherDataList() -> [WeatherData] {
        guard let savedData = UserDefaults.standard.data(forKey: key) else {
            return []
        }

        do {
            let decodedWeatherDataList = try JSONDecoder().decode([WeatherData].self, from: savedData)
            return decodedWeatherDataList
        } catch {
            return []
        }
    }

    // MARK: - Private

    private func saveWeatherDataList(_ weatherDataList: [WeatherData]) {
        guard let encodedWeatherDataList = try? JSONEncoder().encode(weatherDataList) else {
            return
        }
        UserDefaults.standard.setValue(encodedWeatherDataList, forKey: key)
    }
}
