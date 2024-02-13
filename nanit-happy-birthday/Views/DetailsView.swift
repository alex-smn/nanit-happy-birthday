//
//  DetailsView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI
import PhotosUI

struct DetailsView: View {
    @State private var name: String = ""
    @State private var birthday: Date = Date.now
    
    var photoBackgroundView: PhotoBackgroundView { PhotoBackgroundView() }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                DatePicker(selection: $birthday, in: ...Date.now, displayedComponents: .date) {
                    Text("Birthday")
                }
            
                photoBackgroundView
                
                Spacer()
                
                ActionButtonView(
                    action: {
                        print("Show birthday screen")
                    },
                    title: "Show birthday screen",
                    isDisabled: name.isEmpty
                )
            }
            .padding()
            .navigationTitle("Happy Birthday")
        }
    }
}

#Preview {
    DetailsView()
}
