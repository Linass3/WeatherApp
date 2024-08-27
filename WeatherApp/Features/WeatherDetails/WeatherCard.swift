import UIKit

class WeatherCard: UIView {
    private lazy var horizontalStackView: UIStackView = makeHorizontalStackView()
    private lazy var iconView: UIImageView = makeImageView()
    private lazy var weatherConditionLabel: UILabel = makeLabel()
    private lazy var temperatureLabel: UILabel = makeLabel(
        font: UIFont.boldSystemFont(ofSize: 56)
    )
    private lazy var cityLabel: UILabel = makeLabel()
    private lazy var dateLabel: UILabel = makeLabel()

    private let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
        super.init(frame: .zero)
        
        backgroundColor = .white
        setupConstraints()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        weatherConditionLabel.text = weather.weatherType
        temperatureLabel.text = weather.temperature
        cityLabel.text = weather.city
        dateLabel.text = weather.date
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
        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeLabel(font: UIFont = UIFont.systemFont(ofSize: 16)) -> UILabel {
        let label = UILabel()
        label.font = font
        return label
    }
}
