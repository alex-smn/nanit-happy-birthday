//
//  CameraErrorView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI

struct CameraErrorView: View {
    var error: Error?

    var body: some View {
        VStack {
            Text(error?.localizedDescription ?? "")
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(20)
                .foregroundColor(.white)
                .background(Color.red.edgesIgnoringSafeArea(.top))
                .opacity(error == nil ? 0.0 : 1.0)
                .animation(.easeInOut, value: 0.25)

            Spacer()
        }
    }
}

#Preview {
    CameraErrorView()
}
