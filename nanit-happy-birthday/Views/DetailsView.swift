//
//  DetailsView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI
import PhotosUI

struct DetailsView: View {
    @State private var celebrantData = CelebrantData(name: "", dateOfBirth: Date.now, image: nil)
    @FocusState private var isTextFieldFocused: Bool
    private let defaults = UserDefaults.standard
    private var fileURL: URL? { FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image")}
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                TextField("Name", text: $celebrantData.name)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                
                DatePicker(selection: $celebrantData.dateOfBirth, in: ...Date.now, displayedComponents: .date) {
                    Text("Birthday ")
                }
            
                CelebrantPhotoView(colorPalette: .green, image: $celebrantData.image)
                
                Spacer()
                
                ActionButtonView(
                    action: { saveData() },
                    title: "Show birthday screen",
                    isDisabled: celebrantData.name.isEmpty
                )
            }
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
            )
            .padding()
            .navigationTitle("Happy Birthday")
            .ignoresSafeArea(.keyboard)
        }
        .onAppear { loadData() }
    }
    
    private func saveData() {
        defaults.set(celebrantData.name, forKey: UserDefaultsKeys.name)
        defaults.set(celebrantData.dateOfBirth, forKey: UserDefaultsKeys.dateOfBirth)
        
        if let fileURL {
            try? celebrantData.image?.jpegData(compressionQuality: 1)?.write(to: fileURL)
        }
    }
    
    private func loadData() {
        celebrantData.name = defaults.string(forKey: UserDefaultsKeys.name) ?? ""
        celebrantData.dateOfBirth = defaults.value(forKey: UserDefaultsKeys.dateOfBirth) as? Date ?? Date.now
        if let fileURL, let imageData = try? Data(contentsOf: fileURL) {
            celebrantData.image = UIImage(data: imageData)
        }
    }
}

#Preview {
    DetailsView()
}
