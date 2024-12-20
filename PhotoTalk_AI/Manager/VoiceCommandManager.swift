//
//  VoiceCommandManager.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 15.12.2024.
//

import AVKit

final class VoiceCommandManager {
    
    // Singleton: Uygulama genelinde tek bir VoiceCommandManager nesnesi kullanılabilir
    static let shared = VoiceCommandManager()
    private let synthesizer = AVSpeechSynthesizer()
    
    private init() {} // Dışarıdan oluşturulmasını engellemek için private init
    
    /// Belirtilen mesajı sesli olarak çalar
    /// - Parameter command: Çalınacak mesaj
    func voiceCommand(with command: String) {
        let utterance = AVSpeechUtterance(string: command)
        utterance.rate = 0.55
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        synthesizer.speak(utterance)
    }
    
    /// Belirtilen mesajı durdurur (isteğe bağlı bir ek işlev)
    func stopVoiceCommand() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
}
