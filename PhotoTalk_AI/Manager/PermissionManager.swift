import Foundation
import CoreLocation
import AVFoundation
import Photos

protocol PermissionManaging {
    func checkAllPermissions(completion: @escaping (PermissionStatus) -> Void)
}

enum PermissionStatus {
    case allGranted
    case partiallyGranted
    case denied
}

final class PermissionManager: NSObject, PermissionManaging {
    private let locationManager = CLLocationManager()
    private var locationPermissionGranted = false
    private var cameraPermissionGranted = false
    private var galleryPermissionGranted = false

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func checkAllPermissions(completion: @escaping (PermissionStatus) -> Void) {
        let dispatchGroup = DispatchGroup()
        var allPermissionsGranted = true
        
        // Konum izni
        dispatchGroup.enter()
        checkLocationPermission { granted in
            self.locationPermissionGranted = granted
            if !granted { allPermissionsGranted = false }
            dispatchGroup.leave()
        }
        
        // Kamera izni
        dispatchGroup.enter()
        checkCameraPermission { granted in
            self.cameraPermissionGranted = granted
            if !granted { allPermissionsGranted = false }
            dispatchGroup.leave()
        }
        
        // Galeri izni
        dispatchGroup.enter()
        checkGalleryPermission { granted in
            self.galleryPermissionGranted = granted
            if !granted { allPermissionsGranted = false }
            dispatchGroup.leave()
        }
        
        // Tüm izin kontrolleri tamamlandığında
        dispatchGroup.notify(queue: .main) {
            if allPermissionsGranted {
                completion(.allGranted)
            } else if self.locationPermissionGranted || self.cameraPermissionGranted || self.galleryPermissionGranted {
                completion(.partiallyGranted)
            } else {
                completion(.denied)
            }
        }
    }
    
    private func checkLocationPermission(completion: @escaping (Bool) -> Void) {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            completion(true)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            completion(false)
        default:
            completion(false)
        }
    }

    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion(granted)
        }
    }

    private func checkGalleryPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                completion(true)
            default:
                completion(false)
            }
        }
    }
}

extension PermissionManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Bu alan ek işlemler için kullanılabilir
    }
}
