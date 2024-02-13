//
//  ActionButtonView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI

struct ActionButtonView: View {
    var action: () -> Void
    var title: String
    var image: Image? = nil
    var isDisabled: Bool = false
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                image
            }
                .padding(.horizontal, 21)
        }
        .frame(height: 42)
        .background(isDisabled ? Color.disabledButtonColor : Color.buttonColor)
        .foregroundColor(.white)
        .cornerRadius(21)
        .disabled(isDisabled)
    }
}

#Preview {
    ActionButtonView(action: {}, title: "Button")
}
