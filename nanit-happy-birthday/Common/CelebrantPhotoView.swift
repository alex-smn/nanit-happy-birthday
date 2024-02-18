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
    static private let IMAGE_WIDTH = 225.0
    static private let IMAGE_HEIGHT = 225.0

    var colorPalette: ColorPalette
    var image: Binding<UIImage?>
    var isCameraButtonVisible: Bool = true
    
    @StateObject private var cameraManager = CameraManager()
    
    @State private var showingImageSourceDialog: Bool = false
    @State private var showingPicker: Bool = false
    @State private var showingCamera: Bool = false
    
    var body: some View {
        ZStack {
            Image(colorPalette.photoBackgroundImageName)
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
            
            Image(colorPalette.cameraImageName)
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
                .isHidden(!isCameraButtonVisible)
        }
    }
}

#Preview {
    CelebrantPhotoView(colorPalette: .blue, image: .init(get: { UIImage() }, set: { _ in }))
}
