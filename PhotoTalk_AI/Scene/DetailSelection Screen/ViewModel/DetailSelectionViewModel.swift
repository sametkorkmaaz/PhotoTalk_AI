//
//  DetailSelectionViewModel.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import Foundation

protocol DetailSelectionViewModelInterface {
    func viewDidLoad()
}

final class DetailSelectionViewModel {
    weak var view: DetailSelectionViewInterface?
}

extension DetailSelectionViewModel: DetailSelectionViewModelInterface {
    func viewDidLoad() {
        VoiceCommandManager.shared.voiceCommand(with: "Lütfen fotoğrafınızın detaylı açıklanmasını istiyorsanız, ekranın sağ alt kısmına, daha yüzeysel bir anlatım istiyorsanız ekranın sol alt kısmına tıklayın.")
        view?.setupUI()
    }
    
    
}
