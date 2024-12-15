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
}

final class ResultViewController: UIViewController {

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 100 ,y: 150, width: 80, height: 80)) as UIActivityIndicatorView
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 10
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
    private let geminiResultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .ptBack
        label.textColor = .ptSplashBG
        label.layer.masksToBounds = false
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
        
        [imageView, speakerImageView, mlResultLabel, geminiResultLabel].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
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
            
            geminiResultLabel.topAnchor.constraint(equalTo: mlResultLabel.bottomAnchor,constant: 7),
            geminiResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            geminiResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            geminiResultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
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
    
    
}

#Preview("UIKit") {
    ResultViewController()
}
