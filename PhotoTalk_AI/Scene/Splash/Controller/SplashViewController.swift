import UIKit

protocol SplashViewInterface: AnyObject {
    func prepareUI()
    func showPermissionAlert(for permission: String)
    func presentHomeScreen()
    func updateButtonState(isEnabled: Bool)
}

final class SplashViewController: UIViewController {
    
    private let buttonPresent: UIButton = {
        let button = UIButton()
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var viewModel = SplashViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @objc func buttonTapped() {
        if viewModel.areAllPermissionsGranted {
            presentHomeScreen()
        } else {
            viewModel.voiceCommand(with: "Tüm izinler verilmemiş.")
        }
    }
}

extension SplashViewController: SplashViewInterface {
    func prepareUI() {
        view.backgroundColor = .systemBackground
        buttonPresent.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(buttonPresent)
        buttonPresent.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonPresent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonPresent.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonPresent.heightAnchor.constraint(equalToConstant: 50),
            buttonPresent.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func showPermissionAlert(for permission: String) {
        let alert = UIAlertController(
            title: "\(permission) İzinleri Gerekli",
            message: "\(permission) erişimi olmadan uygulamanın bazı özelliklerini kullanamayabilirsiniz.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ayarlar", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        })
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func presentHomeScreen() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    func updateButtonState(isEnabled: Bool) {
        buttonPresent.isEnabled = isEnabled
        buttonPresent.alpha = isEnabled ? 1.0 : 0.5
    }
}
