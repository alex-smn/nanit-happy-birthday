//
//  CameraManager.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import AVFoundation

class CameraManager: ObservableObject {
    @Published var error: CameraError?
    
    private func set(error: CameraError?) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    func checkPermissions() {
        guard
            let _ = AVCaptureDevice.default(
                .builtInWideAngleCamera,
                for: .video,
                position: .back
            )
        else {
            set(error: .cameraUnavailable)
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                if !authorized {
                    self.set(error: .deniedAuthorization)
                }
            }
        case .restricted:
            set(error: .restrictedAuthorization)
        case .denied:
            set(error: .deniedAuthorization)
        case .authorized:
            break
        @unknown default:
            set(error: .unknownAuthorization)
        }
    }
}

