import UIKit

class WeatherDetailsViewController: UIViewController {
    private lazy var weatherCardView: WeatherCard = .init(weatherData: weatherData)
    
    private let weatherData: WeatherData
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupConstraints() {
        weatherCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherCardView)
        NSLayoutConstraint.activate([
            weatherCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weatherCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherCardView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(onBackButtonTap)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func onBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}
