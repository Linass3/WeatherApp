import UIKit

class WeatherCard: UIView {
    // MARK: - UI views

    private lazy var horizontalStackView: UIStackView = makeHorizontalStackView()
    private lazy var iconView: UIImageView = makeImageView()
    private lazy var weatherConditionLabel: UILabel = makeLabel()
    private lazy var temperatureLabel: UILabel = makeLabel(font: UIFont.boldSystemFont(ofSize: 80))
    private lazy var cityLabel: UILabel = makeLabel()
    private lazy var dateLabel: UILabel = makeLabel(alignment: .center)

    private let weatherData: WeatherData
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        super.init(frame: .zero)
        
        backgroundColor = .lightGray
        setupConstraints()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        weatherConditionLabel.text = weatherData.weather.first?.capitalizedDescription
        temperatureLabel.text = weatherData.main.tempString
        cityLabel.text = weatherData.city
        dateLabel.text = weatherData.dateString
        iconView.loadImage(from: "https://openweathermap.org/img/wn/\(weatherData.weather.first?.icon ?? "01d")@2x.png")
    }
    
    private func setupConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(iconView)
        horizontalStackView.addArrangedSubview(weatherConditionLabel)
        addSubview(horizontalStackView)
        addSubview(temperatureLabel)
        addSubview(cityLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            iconView.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            iconView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            iconView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            
            weatherConditionLabel.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor),
            weatherConditionLabel.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cityLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -10),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100)
        ])
    }
    
    private func makeHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    private func makeLabel(
        font: UIFont = UIFont.systemFont(ofSize: 18),
        alignment: NSTextAlignment = NSTextAlignment.left
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = 0
        return label
    }
}
