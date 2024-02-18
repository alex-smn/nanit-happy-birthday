//
//  ViewExtensions.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 18/02/2024.
//

import SwiftUI

extension View {
    @MainActor
    func render(displayScale: CGFloat) -> Image? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}
