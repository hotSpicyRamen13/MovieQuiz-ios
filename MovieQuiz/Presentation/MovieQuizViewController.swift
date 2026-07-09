import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol{
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let alertPresenter = AlertPresenter()
    private var statisticService: StatisticServiceProtocol!
    private var presenter: MovieQuizPresenter!
    
    // MARK: - UI Helpers
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        let model = AlertModel(title: "Ошибка",
                               message: message,
                               buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        alertPresenter.show(in: self, model: model)
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        if isCorrectAnswer {
            imageView.layer.borderColor = UIColor(named: "YP Green (iOS)")?.cgColor
        } else {
            imageView.layer.borderColor = UIColor(named: "YP Red (iOS)")?.cgColor
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statisticService = StatisticService()
        showLoadingIndicator()
        presenter = MovieQuizPresenter(viewController: self)
    }
    
    // MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
    }
    
    // MARK: - View Methods
    
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = nil
        imageView.image = UIImage(data: step.image) ?? UIImage()
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    // MARK: - Private Methods
    
    private func setButtonsEnabled(_ enable: Bool) {
        yesButton.isEnabled = enable
        noButton.isEnabled = enable
    }
    // MARK: - Presenter Callbacks

    func showResultsAlert(message: String) {
        let model = AlertModel(
            title: "Квиз завершен!",
            message: message,
            buttonText: "Сыграть ещё раз"
        ) { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        
        alertPresenter.show(in: self, model: model)
    }
}
