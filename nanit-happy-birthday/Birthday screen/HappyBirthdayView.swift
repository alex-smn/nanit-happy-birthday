//
//  HappyBirthdayView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 15/02/2024.
//

import SwiftUI

struct HappyBirthdayView: View {
    @StateObject private var viewModel = HappyBirthdayViewModel()
        
    @State private var photoViewFrame: CGRect = .zero
    @State private var logoFrame: CGRect = .zero
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        postcardView(size: geometry.size)
                        
                        if let shareImage = postcardView(size: geometry.size, isForScreenshot: true).render(displayScale: displayScale) {
                            ShareLink(
                                item: shareImage,
                                preview: SharePreview("Share the news", image: shareImage)
                            ) {
                                ActionButtonView(title: "Share the news", image: Image(systemName: "arrowshape.turn.up.right.fill"))
                            }
                            .offset(y: logoFrame.maxY + 22)
                        }
                    }
                }
                .ignoresSafeArea()
                
                Button {
                    dismiss()
                } label: {
                    Image("BackArrow")
                }
                .padding(15)
            }
            
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

private extension HappyBirthdayView {
    func postcardView(size: CGSize, isForScreenshot: Bool = false) -> some View {
        ZStack(alignment: .top) {
            Color(viewModel.colorPalette.backgroundColorName)
                .frame(width: size.width, height: size.height)
            
            CelebrantPhotoView(colorPalette: viewModel.colorPalette, image: $viewModel.celebrantData.image, isCameraButtonVisible: !isForScreenshot)
                .padding(.horizontal, 50)
                .overlay {
                    GeometryReader { photoViewGeometry in
                        Color.clear
                            .onChange(of: photoViewGeometry.frame(in: .global)) { newValue in
                                photoViewFrame = newValue
                            }
                    }
                }
                .position(x: size.width / 2, y: size.height / 2 + 70)
            
            BackgroundImageView(name: viewModel.colorPalette.backgroundImageName, backgroundFrame: size)
                .allowsHitTesting(false)
            
            CongratulationsView(name: viewModel.celebrantData.name, dateOfBirth: viewModel.celebrantData.dateOfBirth)
                .frame(height: photoViewFrame.minY)
                .padding(.vertical, 20)
                .padding(.horizontal, 50)
            
            Image("Logo")
                .overlay {
                    GeometryReader { logoGeometry in
                        Color.clear
                            .onChange(of: logoGeometry.frame(in: .global)) { newValue in
                                logoFrame = newValue
                            }
                    }
                }
                .offset(y: photoViewFrame.maxY + 15)
        }
        .onChange(of: viewModel.celebrantData.image) { _ in
            viewModel.saveData()
        }
        .frame(width: size.width, height: size.height)
    }
}

#Preview {
    HappyBirthdayView()
}
