//
//  CongratulationsView.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 15/02/2024.
//

import SwiftUI

struct CongratulationsView: View {
    let name: String
    let dateOfBirth: Date
    
    private var topText: String {
        "TODAY \(name.uppercased()) IS"
    }
    
    private var bottomText: String {
        "\(age.isMonths ? "MONTH" : "YEAR")\(age.value == 1 ? "" : "S") OLD!"
    }
    
    var body: some View {
        VStack {
            Text(topText)
                .font(.system(size: 21, weight: .medium))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .foregroundColor(.textColor)
            
            HStack(spacing: 22) {
                Image("SwirlsLeft")
                AgeView(age: age.value)
                Image("SwirlsRight")
            }
            .padding(.top, 13)
            .padding(.bottom, 14)
            
            Text(bottomText)
                .font(.system(size: 21, weight: .medium))
                .foregroundColor(.textColor)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(topText + " \(age.value) " + bottomText)
        
    }
    
    private var age: (value: Int, isMonths: Bool) {
        let components = Calendar.current.dateComponents([.year, .month], from: dateOfBirth, to: .now)
        guard
            let years = components.year,
            let months = components.month
        else {
            return (value: 0, isMonths: true)
        }
        
        return years > 0 ? (value: years, isMonths: false) : (value: months > 0 ? months : 1, isMonths: true)
    }
}

private struct AgeView: View {
    let age: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(Array(String(age)), id: \.self) { digit in
                Image("\(digit)")
            }
        }
    }
}

#Preview {
    CongratulationsView(name: "CRISTIANO RONALDO JUNIOR", dateOfBirth: Calendar.current.date(byAdding: .year, value: -115, to: Date.now) ?? Date.now)
}
