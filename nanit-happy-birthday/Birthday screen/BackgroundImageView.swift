//
//  BackgroundImageView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 17/02/2024.
//

import SwiftUI
import UIKit

struct BackgroundImageView: View {
    
    let name: String
    @State private var backgroundFrame: CGSize = .zero
    
    private func image(name: String, parentSize: CGSize) -> UIImage {
        if let uiImage = UIImage(named: name) {
            let imageSize = uiImage.size
            let imageScale = parentSize.width / imageSize.width
            DispatchQueue.main.async {
                self.backgroundFrame = CGSize(width: imageSize.width * imageScale, height: imageSize.height * imageScale)
            }
            return uiImage
        }
        
        return UIImage()
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: image(name: name, parentSize: geometry.size))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: backgroundFrame.width, height: backgroundFrame.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height - backgroundFrame.height / 2)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
