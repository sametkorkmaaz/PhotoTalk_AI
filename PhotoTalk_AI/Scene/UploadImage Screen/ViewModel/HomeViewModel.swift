//
//  HomeViewModel.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import Foundation
import UIKit


protocol HomeViewModelInterface {
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.prepareUI()
        VoiceCommandManager.shared.voiceCommand(with: "Lütfen yüklemek istediğiniz fotoğrafı kamera ile çekmek istiyorsanız, telefon ekranının yarıdan altına tıklayın. Galeriden yüklemek istiyorsanız, ekranın yarısından üstüne tıklayın.")
    }
    
    
}
