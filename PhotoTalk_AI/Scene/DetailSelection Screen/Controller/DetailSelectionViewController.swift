//
//  DetailSelectionViewController.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import UIKit

protocol DetailSelectionViewInterface: AnyObject {
    func setupUI()
}

final class DetailSelectionViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .ptSplashBG
        return imageView
    }()
    
    private let lessDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yüzeysel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.ptSplashBG, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.ptBlue.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .ptBack

        // SF Symbol için büyük yapılandırma
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        let buttonImage = UIImage(systemName: "chevron.down.2", withConfiguration: largeConfig)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .ptSplashBG // Sembol rengi
        return button
    }()

    private let moreDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detaylı", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.ptSplashBG, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.ptBlue.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .ptBack

        // SF Symbol için büyük yapılandırma
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        let buttonImage = UIImage(systemName: "chevron.up.2", withConfiguration: largeConfig)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .ptSplashBG // Sembol rengi

        return button
    }()
    
    var myImage: UIImage? {
        didSet {
            imageView.image = myImage
        }
    }
    
    private lazy var viewModel = DetailSelectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc func moreDetailButtonTapped() {
        VoiceCommandManager.shared.stopVoiceCommand()
        let vc = ResultViewController()
        vc.responseImage = myImage
        vc.promtDetailSelection = "detaylı"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func lessDetailButtonTapped() {
        VoiceCommandManager.shared.stopVoiceCommand()
        let vc = ResultViewController()
        vc.responseImage = myImage
        vc.promtDetailSelection = "yüzeysel"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension DetailSelectionViewController: DetailSelectionViewInterface {
    func setupUI() {
        view.backgroundColor = .ptSplashBG
        
        moreDetailButton.addTarget(self, action: #selector(moreDetailButtonTapped), for: .touchUpInside)
        lessDetailButton.addTarget(self, action: #selector(lessDetailButtonTapped), for: .touchUpInside)
        
        [imageView, lessDetailButton, moreDetailButton].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            moreDetailButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7),
            moreDetailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moreDetailButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moreDetailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            
            lessDetailButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7),
            lessDetailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lessDetailButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lessDetailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
        ])
    }
}

#Preview("UIKit") {
    DetailSelectionViewController()
}
