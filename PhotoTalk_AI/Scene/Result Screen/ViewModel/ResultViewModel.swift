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
    weak var view: ResultViewInterface?
    
    var responseImage: UIImage?
}

extension ResultViewModel: ResultViewModelInterface {
    
    func viewDidLoad() {
        view?.setupUI()
        VoiceCommandManager.shared.voiceCommand(with: "Fotoğrafınız analiz ediliyor. Lütfen bekleyin.")
        view?.setupActivityIndicator()
        self.fetchGemini()
    }
    
    
    func fetchGemini() {
        GeminiManager.shared.fetchGemini(image: self.responseImage!, prompt: "Bu fotoğrafı detaylı şekilde anlat.") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseText):
                    VoiceCommandManager.shared.voiceCommand(with: responseText)
                    self.view?.updateGeminiResultLabel(with: responseText)
                    self.view?.stopActivityIndicator()
                    print("Yanıt: \(responseText)")
                case .failure(let error):
                    self.fetchGemini()
                    VoiceCommandManager.shared.voiceCommand(with: "Fotoğrafınız analiz ediliyor. Lütfen bekleyin.")
                    print("hata aldı bi daha")
                    print("Hata: \(error.localizedDescription)")
                }
            }
        }
    }
}
