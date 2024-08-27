import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let dt: Int
    let name: String

    var city: String {
        return name
    }

    var date: Date {
        let dateTimeInterval = TimeInterval(dt)
        return Date(timeIntervalSince1970: dateTimeInterval)
    }

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date)
    }
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double

    var tempString: String {
        return "\(temp)°"
    }
}
