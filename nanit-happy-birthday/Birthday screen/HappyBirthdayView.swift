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
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        Color(viewModel.colorPalette.backgroundColorName)
                        
                        CelebrantPhotoView(colorPalette: viewModel.colorPalette, image: $viewModel.celebrantData.image)
                            .padding(.horizontal, 50)
                            .overlay {
                                GeometryReader { photoViewGeometry in
                                    Color.clear
                                        .onChange(of: photoViewGeometry.frame(in: .global)) { newValue in
                                            photoViewFrame = newValue
                                        }
                                }
                            }
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 70)
                        
                        BackgroundImageView(name: viewModel.colorPalette.backgroundImageName)
                        
                        CongratulationsView(name: viewModel.celebrantData.name, dateOfBirth: viewModel.celebrantData.dateOfBirth)
                            .frame(height: photoViewFrame.minY)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 50)
                            
                        Image("Logo")
                        .offset(y: photoViewFrame.maxY + 15)
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
        .onChange(of: viewModel.celebrantData.image) { _ in
            viewModel.saveData()
        }
    }
}

#Preview {
    HappyBirthdayView()
}
