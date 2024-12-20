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
        
        GeminiManager.shared.fetchGemini(image: originalImage, prompt: "Bu fotoğrafı \(promtDetailSelection!) şekilde bir görme engelli bireye anlat. Görme engelli bireyin fotoğrafı kafasında canlandıra bileceği şekilde anlat. Görme engelli bireyin yürürken dikkat etmesi gereken bir durum var ise bunu metinde belirt yoksa belirtmene gerek yok. Dönüş olarak sadece fotoğrafı anlattığın metni ver. Başka hiçbir şey yazma. Devrik cümleler kurma. Fotoğrafı güzel betimle.") { result in
            print(self.promtDetailSelection!)
            DispatchQueue.main.async {
                switch result {
                case .success(let responseText):
                    VoiceCommandManager.shared.voiceCommand(with: "\(responseText) Yeni bir görsel göndermek ister misiniz?")
                    self.view?.updateGeminiResultLabel(with: responseText)
                    self.view?.stopActivityIndicator()
                    print("Yanıt: \(responseText)")
                case .failure(let error):
                    self.fetchGemini()
                    //VoiceCommandManager.shared.voiceCommand(with: "Fotoğrafınız analiz ediliyor. Lütfen bekleyin.")
                    print("Hata: \(error.localizedDescription)")
                }
            }
        }
    }
}
