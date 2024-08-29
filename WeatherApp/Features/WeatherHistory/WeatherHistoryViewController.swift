import UIKit

class WeatherHistoryViewController: UIViewController {
    private lazy var emptyHistoryLabel: UILabel = makeUILabel()
    private lazy var scrollView: UIScrollView = makeUIScrollView()

    private let weatherHistoryViewModel: WeatherHistoryViewModel

    init(weatherHistoryViewModel: WeatherHistoryViewModel) {
        self.weatherHistoryViewModel = weatherHistoryViewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray5
        setupNavigationBar()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        if weatherHistoryViewModel.weatherDataList.isEmpty {
            setupEmptyLabelView()
        } else {
            setupScrollView()
        }
    }

    private func setupEmptyLabelView() {
        emptyHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyHistoryLabel)
        NSLayoutConstraint.activate([
            emptyHistoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyHistoryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        populateWithWeatherCards()
    }

    private func populateWithWeatherCards() {
        var previousView: UIView?
        let weatherCardHeight: CGFloat = 200

        for weatherData in weatherHistoryViewModel.weatherDataList {
            let weatherCardView = WeatherCard(weatherData: weatherData)
            weatherCardView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(weatherCardView)
            NSLayoutConstraint.activate([

                weatherCardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                weatherCardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                weatherCardView.heightAnchor.constraint(equalToConstant: weatherCardHeight)
            ])

            if let previousView {
                weatherCardView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20).isActive = true
            } else {
                weatherCardView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            }

            previousView = weatherCardView
            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: CGFloat(5) * 220)
        }
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

    private func makeUILabel() -> UILabel {
        let uiLabel = UILabel()
        uiLabel.text = "There are no recent searches"
        return uiLabel
    }

    private func makeUIScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
}
