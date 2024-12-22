import UIKit

protocol SplashViewInterface: AnyObject {
    func prepareUI()
    func showPermissionAlert(for permission: String)
    func presentHomeScreen()
}

final class SplashViewController: UIViewController {
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SplashBG")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var viewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SplashViewController: SplashViewInterface {
    func prepareUI() {
        view.backgroundColor = .ptBack
        
        [bgImageView].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
}
