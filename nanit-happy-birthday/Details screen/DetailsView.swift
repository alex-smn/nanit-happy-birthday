//
//  DetailsView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI
import PhotosUI

struct DetailsView: View {
    @StateObject private var viewModel = DetailsViewModel()    
    @FocusState private var isTextFieldFocused: Bool
    @State private var shouldNavigate = false
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                ZStack {
                    Color.greenBackgroundColor
                        .ignoresSafeArea()
                        .onTapGesture {
                            isTextFieldFocused = false
                        }
                    
                    VStack(spacing: 22) {
                        Spacer()
                        
                        TextField("Name", text: $viewModel.celebrantData.name)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .focused($isTextFieldFocused)
                            .submitLabel(.done)
                        
                        DatePicker(selection: $viewModel.celebrantData.dateOfBirth, in: ...Date.now, displayedComponents: .date) {
                            Text("Birthday ")
                        }
                        
                        Spacer()
                        
                        CelebrantPhotoView(colorPalette: .green, image: $viewModel.celebrantData.image)
                        
                        Spacer()
                        
                        Button {
                            viewModel.saveData()
                            shouldNavigate = true
                        } label: {
                            ActionButtonView(
                                title: "Show birthday screen",
                                isDisabled: viewModel.celebrantData.name.isEmpty
                            )
                            .padding(.vertical, 20)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
                .preferredColorScheme(.light)
                .navigationTitle("Happy Birthday")
                .onAppear {
                    viewModel.loadData()
                }
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        viewModel.saveData()
                    }
                }
                .navigationDestination(isPresented: $shouldNavigate) {
                    HappyBirthdayView()
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    DetailsView()
}
