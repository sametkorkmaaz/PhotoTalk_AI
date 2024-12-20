//
//  ResultViewController.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import UIKit

protocol ResultViewInterface: AnyObject {
    func setupUI()
    func setupActivityIndicator()
    func startActivityIndicator()
    func stopActivityIndicator()
    
    func updateGeminiResultLabel(with text: String)
}

final class ResultViewController: UIViewController {

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 100 ,y: 150, width: 80, height: 80)) as UIActivityIndicatorView
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 10
        imageView.layer.borderColor = UIColor.ptBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.shadowOpacity = 0.5
        imageView.backgroundColor = .ptBack
        return imageView
    }()
    private let speakerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .ptSplashBG
        imageView.image = UIImage(systemName: "speaker.wave.3.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let mlResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ptSplashBG
        label.text = "Kadınlar futbol oynuyorKadınlar futbol oynuyor."
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let geminiResultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .ptBack
        label.textColor = .ptSplashBG
        label.textAlignment = .left
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 10
        label.layer.shadowOpacity = 0.5
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    var responseImage: UIImage? {
        didSet {
            imageView.image = responseImage
            viewModel.responseImage = responseImage
        }
    }
    
    private lazy var viewModel = ResultViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension ResultViewController: ResultViewInterface {
    
    func setupUI() {
        view.backgroundColor = .ptBack
        
        [imageView, speakerImageView, mlResultLabel, geminiResultLabel, scrollView].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.addSubview(geminiResultLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            speakerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            speakerImageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            speakerImageView.heightAnchor.constraint(equalToConstant: 50),
            speakerImageView.widthAnchor.constraint(equalToConstant: 50),
            
            
            mlResultLabel.leadingAnchor.constraint(equalTo: speakerImageView.trailingAnchor, constant: 16),
            mlResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mlResultLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            mlResultLabel.heightAnchor.constraint(equalTo: speakerImageView.heightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: mlResultLabel.bottomAnchor,constant: 7),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            geminiResultLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            geminiResultLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            geminiResultLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            geminiResultLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            geminiResultLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
        ])
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .ptBlue
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.backgroundColor = .ptSplashBG
        activityIndicator.layer.cornerRadius = 10
        self.view.addSubview(activityIndicator)
        startActivityIndicator()
        }
    
    func startActivityIndicator() {
        print("start")
        activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func updateGeminiResultLabel(with text: String) {
        geminiResultLabel.text = text
    }
}

/*#Preview("UIKit") {
    ResultViewController()
} */
