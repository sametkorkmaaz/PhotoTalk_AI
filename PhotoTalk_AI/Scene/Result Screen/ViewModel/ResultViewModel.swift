//
//  ResultViewModel.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import Foundation
import UIKit

protocol ResultViewModelInterface {
    func viewDidLoad()
    func fetchGemini()
}

final class ResultViewModel {
    var service = FirebaseAIService()
    weak var view: ResultViewInterface?
    
    var responseImage: UIImage?
    var promtDetailSelection: String?
}

extension ResultViewModel: ResultViewModelInterface {
    
    func viewDidLoad() {
        view?.setupUI()
        VoiceCommandManager.shared.voiceCommand(with: "Fotoğrafınız analiz ediliyor. Lütfen bekleyin.")
        view?.setupActivityIndicator()
        self.fetchGemini()
    }
    
    
    func fetchGemini() {
        guard let originalImage = self.responseImage else {
            print("Görsel bulunamadı.")
            return
        }
        
        Task {
            do {
                let response = try await service.imageToText(for: originalImage)
                VoiceCommandManager.shared.voiceCommand(with: "\(response) Yeni bir görsel göndermek ister misiniz? Fotoğraf yükleme ekranına dönmek için ekranın üst kısmına tıklayın.")
                self.view?.updateGeminiResultLabel(with: response)
                self.view?.stopActivityIndicator()
                self.view?.backUploadImageScreenButtonHidden()
                print("Yanıt: \(response)")
            } catch {
                self.fetchGemini()
                print("Hata: \(error.localizedDescription)")
            }
        }
    }
}
