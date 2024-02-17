//
//  DetailsViewModel.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 16/02/2024.
//

import Foundation
import UIKit

class DetailsViewModel: ObservableObject {
    @Published var celebrantData: CelebrantData
    private let dataSource = DataSource()
    
    init() { 
        celebrantData = dataSource.loadData()
    }
    
    func saveData() {
        dataSource.saveName(celebrantData.name)
        dataSource.saveBirthday(celebrantData.dateOfBirth)
        if let image = celebrantData.image {
            dataSource.saveImage(image)
        }
    }
    
    func loadData() {
        celebrantData = dataSource.loadData()
    }
}
