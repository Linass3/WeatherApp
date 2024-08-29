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
        dateFormatter.dateFormat = "MMM\nd"
        return dateFormatter.string(from: date).uppercased()
    }
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String

    var capitalizedDescription: String {
        return description.prefix(1).uppercased() + description.dropFirst()
    }
}

struct Main: Codable {
    let temp: Double

    var tempString: String {
        return "\(String(format: "%.0f", temp))°"
    }
}
