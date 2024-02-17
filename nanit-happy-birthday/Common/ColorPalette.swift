//
//  ColorPalette.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import Foundation

enum ColorPalette: CaseIterable {
    case green
    case yellow
    case blue

    var backgroundImageName: String {
        switch self {
        case .green:
            "BackgroundGreen"
        case .yellow:
            "BackgroundYellow"
        case .blue:
            "BackgroundBlue"
        }
    }
    
    var backgroundColorName: String {
        switch self {
        case .green:
            "BackgroundColorGreen"
        case .yellow:
            "BackgroundColorYellow"
        case .blue:
            "BackgroundColorBlue"
        }
    }
    
    var photoBackgroundImageName: String {
        switch self {
        case .green:
            "PhotoBackgroundGreen"
        case .yellow:
            "PhotoBackgroundYellow"
        case .blue:
            "PhotoBackgroundBlue"
        }
    }
    
    var cameraImageName: String {
        switch self {
        case .green:
            "CameraIconGreen"
        case .yellow:
            "CameraIconYellow"
        case .blue:
            "CameraIconBlue"
        }
    }
}
