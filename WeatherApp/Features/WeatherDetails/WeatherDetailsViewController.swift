import UIKit

class WeatherDetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBackButtonTap))
        navigationItem.leftBarButtonItem = backButton
        
        let mockWeather = Weather(weatherType: "Broken clouds", temperature: "14*", city: "Vilnius", date: "SAT 01", icon: "star")
        let weatherCardView = WeatherCard(weather: mockWeather)
        
        weatherCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherCardView)
        NSLayoutConstraint.activate([
            weatherCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weatherCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherCardView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    @objc
    private func onBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}
