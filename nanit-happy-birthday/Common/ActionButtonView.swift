//
//  ActionButtonView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 13/02/2024.
//

import SwiftUI

struct ActionButtonView: View {
    var title: String
    var image: Image? = nil
    var isDisabled: Bool = false
    
    static let BUTTON_HEIGHT = 42.0
    
    var body: some View {
        HStack {
            Text(title)
            image
        }
        .padding(.horizontal, 21)
        .frame(height: ActionButtonView.BUTTON_HEIGHT)
        .background(isDisabled ? Color.disabledButtonColor : Color.buttonColor)
        .foregroundColor(.white)
        .cornerRadius(21)
        .disabled(isDisabled)
    }
}

#Preview {
    ActionButtonView(title: "Button")
}
