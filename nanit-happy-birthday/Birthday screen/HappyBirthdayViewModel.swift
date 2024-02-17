//
//  HappyBirthdayViewModel.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 16/02/2024.
//

import Foundation
import UIKit

class HappyBirthdayViewModel: ObservableObject {
    @Published var celebrantData: CelebrantData
    
    let colorPalette: ColorPalette
    private let dataSource = DataSource()
    
    init() {
        celebrantData = dataSource.loadData()
        colorPalette = ColorPalette.allCases.randomElement()!
    }
    
    func saveData() {
        if let image = celebrantData.image {
            dataSource.saveImage(image)
        }
    }
}
