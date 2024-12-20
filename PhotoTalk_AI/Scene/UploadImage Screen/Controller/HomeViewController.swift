//
//  HomeViewController.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 13.12.2024.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func prepareUI()
    func presentDetailSelectionScreen(with image: UIImage)
}

final class HomeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    private let cameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .ptBack
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.ptBlue.cgColor

        // SF Symbol: camera.fill
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        let cameraImage = UIImage(systemName: "camera.fill", withConfiguration: largeConfig)
        button.setImage(cameraImage, for: .normal)
        button.tintColor = .ptSplashBG // Sembol rengi
        return button
    }()
    private let ptLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appLogo")
        return imageView
    }()
    
    private let ptLabel: UILabel = {
        let label = UILabel()
        label.text = "PhotoTalk AI"
        label.font = .systemFont(ofSize: .init(30), weight: .bold)
        label.textColor = .ptBack
        return label
    }()
    private let galleryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .ptBack
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.ptBlue.cgColor

        // SF Symbol: photo.on.rectangle.angled
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        let galleryImage = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: largeConfig)
        button.setImage(galleryImage, for: .normal)
        button.tintColor = .ptSplashBG // Sembol rengi
        return button
    }()
    
    let imagePicker = UIImagePickerController()
    private lazy var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @objc func cameraButtonTapped() {
        VoiceCommandManager.shared.stopVoiceCommand()
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Kamera mevcut değil.")
            return
        }
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func galleryButtonTapped() {
        VoiceCommandManager.shared.stopVoiceCommand()
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Galeriye erişim yok.")
            return
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    // Görsel seçimi tamamlandığında veya iptal edildiğinde tetiklenir
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?

        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }

        picker.dismiss(animated: true) {
            if let image = selectedImage {
                // 7MB kotrolü yap.
                self.presentDetailSelectionScreen(with: image)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewInterface {
    
    func prepareUI() {
        view.backgroundColor = .ptSplashBG
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        
        [cameraButton, galleryButton, ptLogo, ptLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: view.topAnchor),
            galleryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            ptLogo.topAnchor.constraint(equalTo: galleryButton.bottomAnchor),
            ptLogo.bottomAnchor.constraint(equalTo: cameraButton.topAnchor),
            ptLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ptLogo.widthAnchor.constraint(equalToConstant: 100),
            
            ptLabel.leadingAnchor.constraint(equalTo: ptLogo.trailingAnchor, constant: 20),
            ptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ptLabel.topAnchor.constraint(equalTo: ptLogo.topAnchor),
            ptLabel.bottomAnchor.constraint(equalTo: ptLogo.bottomAnchor),
            
            cameraButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cameraButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
        ])
    }
    
    func presentDetailSelectionScreen(with image: UIImage) {
        let presentVC = DetailSelectionViewController()
        presentVC.modalPresentationStyle = .overFullScreen
        presentVC.myImage = image // Görseli DetailSelectionViewController'a aktarıyoruz
        present(presentVC, animated: true) {
            print("DetailSelectionViewController sunuldu.")
        }
    }
}

#Preview("UIKit") {
    HomeViewController()
}
