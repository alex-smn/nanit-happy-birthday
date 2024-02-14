//
//  CelebrantPhotoView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI
import PhotosUI
import UIKit

struct CelebrantPhotoView: View {
    static let IMAGE_WIDTH = 220.0
    static let IMAGE_HEIGHT = 220.0
    
    enum PhotoPickerColor {
        case green
        case yellow
        case blue
        
        var colorName: String {
            switch self {
            case .green:
                "Green"
            case .yellow:
                "Yellow"
            case .blue:
                "Blue"
            }
        }
    }
    
    var colorPalette: PhotoPickerColor
    
    var image: Binding<UIImage?>
    @StateObject private var cameraManager = CameraManager()
    
    @State private var showingImageSourceDialog: Bool = false
    @State private var showingPicker: Bool = false
    @State private var showingCamera: Bool = false
    
    var body: some View {
        ZStack {
            Image("PhotoBackground\(colorPalette.colorName)")
                .resizable()
                .frame(width: CelebrantPhotoView.IMAGE_WIDTH, height: CelebrantPhotoView.IMAGE_HEIGHT)
            
            if let image = image.wrappedValue {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: CelebrantPhotoView.IMAGE_WIDTH, height: CelebrantPhotoView.IMAGE_HEIGHT)
                    .clipShape(
                        Circle()
                            .inset(by: 7)
                    )
            }
            
            Image("CameraIcon\(colorPalette.colorName)")
                .offset(x: CelebrantPhotoView.IMAGE_WIDTH * sqrt(2) / 4, y: -CelebrantPhotoView.IMAGE_HEIGHT * sqrt(2) / 4)
                .onTapGesture {
                    showingImageSourceDialog.toggle()
                }
                .confirmationDialog("Picture", isPresented: $showingImageSourceDialog) {
                    Button {
                        cameraManager.checkPermissions()
                        showingCamera.toggle()
                    } label: {
                        Label("Camera", systemImage: "camera")
                    }
                    
                    Button {
                        showingPicker.toggle()
                    } label: {
                        Label("Gallery", systemImage: "photo.artframe")
                    }
                }
                .sheet(isPresented: $showingCamera) {
                    ZStack(alignment: .topLeading) {
                        if ImagePicker.isSourceTypeAvailable(.camera),
                            cameraManager.error == nil {
                            ImagePicker(sourceType: .camera, selectedImage: self.image)
                        } else {
                            CameraErrorView(error: cameraManager.error)
                            Button("Close") {
                                showingCamera.toggle()
                            }
                            .padding(20)
                            .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $showingPicker) {
                    if ImagePicker.isSourceTypeAvailable(.photoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.image)
                    }
                }
        }
    }
}

#Preview {
    CelebrantPhotoView(colorPalette: .blue, image: .init(get: { UIImage() }, set: { _ in }))
}
