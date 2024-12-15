//
//  ResultViewModel.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import Foundation

protocol ResultViewModelInterface {
    func viewDidLoad()
}

final class ResultViewModel {
    weak var view: ResultViewInterface?
}

extension ResultViewModel: ResultViewModelInterface {
    func viewDidLoad() {
        view?.setupUI()
        VoiceCommandManager.shared.voiceCommand(with: "Fotoğrafınız analiz ediliyor. Lütfen bekleyin.")
        view?.setupActivityIndicator()
    }
}
