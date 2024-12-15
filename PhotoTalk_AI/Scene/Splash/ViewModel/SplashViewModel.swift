import Foundation
import AVKit

protocol SplashViewModelInterface: AnyObject {
    func viewDidLoad()
    func voiceCommand(with command: String)
    var areAllPermissionsGranted: Bool { get }
    func checkNetworkAndProceed()
}

final class SplashViewModel {
    weak var view: SplashViewInterface?
    private let permissionManager: PermissionManaging
    private let synthesizer = AVSpeechSynthesizer()
    private(set) var areAllPermissionsGranted = false
    private let networkMonitor: NetworkMonitorInterface

    init(permissionManager: PermissionManaging = PermissionManager(), networkMonitor: NetworkMonitorInterface = NetworkMonitor.shared) {
        self.permissionManager = permissionManager
        self.networkMonitor = networkMonitor
    }


    private func checkPermissions() {
        permissionManager.checkAllPermissions { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .allGranted:
                self.areAllPermissionsGranted = true
                self.view?.updateButtonState(isEnabled: true)
            case .partiallyGranted:
                self.areAllPermissionsGranted = false
                self.voiceCommand(with: "Lütfen gerekli tüm izinleri verin.")
                self.view?.updateButtonState(isEnabled: false)
            case .denied:
                self.areAllPermissionsGranted = false
                self.voiceCommand(with: "Lütfen gerekli tüm izinleri verin.")
                self.view?.updateButtonState(isEnabled: false)
                self.view?.showPermissionAlert(for: "Konum, Kamera ve Galeri")
            }
        }
    }

}

extension SplashViewModel: SplashViewModelInterface {
    
    func viewDidLoad() {
        _ = NetworkMonitor.shared
        view?.prepareUI()
        voiceCommand(with: "Photo Talk'a hoşgeldiniz.")
        checkPermissions()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.checkNetworkAndProceed()
        }
    }
    
    func checkNetworkAndProceed() {
        if networkMonitor.isConnected {
            view?.presentHomeScreen()
        } else {
            voiceCommand(with: "Lütfen internet bağlantınızı sağlayın ve uygulamayı yeniden başlatın.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                self.checkNetworkAndProceed()
            }
        }
    }
    
    func voiceCommand(with command: String) {
        let utterance = AVSpeechUtterance(string: command)
        utterance.rate = 0.55
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        synthesizer.speak(utterance)
    }
}
