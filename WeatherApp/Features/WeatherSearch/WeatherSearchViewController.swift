import Combine
import UIKit

class WeatherSearchViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let textFieldPlaceholderText: String = "Enter city name"
        static let searchButtonTitle: String = "Go!"
        static let historyButtonTitle: String = "History"
    }

    // MARK: - UI elements

    private lazy var imageView: UIImageView = makeImageView()
    private lazy var searchButton: UIButton = makeUIButton(
        with: Constants.searchButtonTitle
    )
    private lazy var historyButton: UIButton = makeUIButton(
        with: Constants.historyButtonTitle
    )
    private lazy var textField: UITextField = makeTextField(
        with: Constants.textFieldPlaceholderText
    )
    private lazy var verticalStackView: UIStackView = makeStackView(.vertical)
    private lazy var horizontalStackView: UIStackView = makeStackView(.horizontal)

    // MARK: - Properties

    private var viewModel: WeatherSearchViewModel
    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: WeatherSearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Livecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupUI()
        setupBindings()
    }

    // MARK: - Private

    private func setupUI() {
        setupConstraints()

        textField.addTarget(
            self,
            action: #selector(onTextFieldDidChange),
            for: .editingChanged
        )
        setupButtonActions()
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        horizontalStackView.addArrangedSubview(textField)
        horizontalStackView.addArrangedSubview(searchButton)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        view.addSubview(verticalStackView)
        view.addSubview(historyButton)

        let aspectRatio: CGFloat = 16.0 / 9.0
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            imageView.topAnchor.constraint(equalTo: verticalStackView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / aspectRatio),

            horizontalStackView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),

            textField.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            textField.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),

            searchButton.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            searchButton.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 50),

            historyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            historyButton.widthAnchor.constraint(equalToConstant: 100),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.weatherData
            .receive(on: RunLoop.main)
            .sink { [weak self] weatherData in
                guard let self else { return }

                let weatherDetailsViewController = WeatherDetailsViewController(weatherData: weatherData)
                navigationController?.pushViewController(weatherDetailsViewController, animated: true)
            }
            .store(in: &subscriptions)
    }

    private func makeImageView() -> UIImageView {
        let image = UIImage(named: "Image1")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private func makeUIButton(with title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }

    private func makeTextField(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2.0
        textField.borderStyle = .roundedRect
        return textField
    }

    private func makeStackView(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }

    private func setupButtonActions() {
        searchButton.addTarget(
            self,
            action: #selector(onSearchButtonTap),
            for: .touchUpInside
        )
        historyButton.addTarget(
            self,
            action: #selector(onHistoryButtonTap),
            for: .touchUpInside
        )
    }

    // MARK: - IBActions

    @objc private func onSearchButtonTap() {
        viewModel.onSearchButtonDidSelect()
    }

    @objc private func onHistoryButtonTap() {
        viewModel.onHistoryButtonDidSelect()
    }

    @objc private func onTextFieldDidChange() {
        guard let text = textField.text else { return }
        viewModel.onSearchTextChange(text: text)
    }
}
