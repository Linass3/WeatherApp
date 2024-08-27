import Foundation

protocol WeatherSearchViewModel {
    func onSearchButtonDidSelect()
    func onHistoryButtonDidSelect()
    func onSearchTextChange(text: String)
}

final class DefaultWeatherSearchViewModel: WeatherSearchViewModel {
    // MARK: - WeatherSearchViewModel
    
    func onSearchButtonDidSelect() {
        print("search")
    }
    
    func onHistoryButtonDidSelect() {
        print("history")
    }
    
    func onSearchTextChange(text: String) {
        print(text)
    }
}
