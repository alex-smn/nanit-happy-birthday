//
//  PhotoBackgroundView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI
import PhotosUI

struct PhotoBackgroundView: View {
    @State private var photoImage: Image?
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        ZStack {
            Image("PhotoBackgroundGreen")
                .resizable()
                .frame(width: 220, height: 220)
            
            photoImage?
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .clipShape(
                    Circle()
                        .inset(by: 6)
                )
            
            PhotosPicker(selection: $photoItem, matching: .images) {
                Image("CameraIconGreen")
            }
            .offset(x: 220 * sqrt(2) / 4, y: -220 * sqrt(2) / 4)
        }
        .onChange(of: photoItem) {
            Task {
                if let loaded = try? await photoItem?.loadTransferable(type: Image.self) {
                    photoImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    PhotoBackgroundView()
}
