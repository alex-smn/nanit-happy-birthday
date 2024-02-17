//
//  DataSource.swift
//  nanit-happy-birthday
//
//  Created by Alexander Livshits on 16/02/2024.
//

import Foundation
import UIKit

class DataSource {
    
    enum UserDefaultsKeys {
        static let name = "CelebrantName"
        static let dateOfBirth = "CelebrantDateOfBirth"
    }
    
    private let defaults = UserDefaults.standard
    private let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image")
    
    func saveName(_ name: String) {
        defaults.setValue(name, forKey: UserDefaultsKeys.name)
    }
    
    func saveBirthday(_ date: Date) {
        defaults.setValue(date, forKey: UserDefaultsKeys.dateOfBirth)
    }
    
    func saveImage(_ image: UIImage) {
        if let fileURL {
            do {
                try image.jpegData(compressionQuality: 1)?.write(to: fileURL)
            } catch {
                print("Can't save image: \(error)")
            }
        } else {
            print("Can't create image file")
        }
    }
    
    func loadData() -> CelebrantData {
        var celebrant = CelebrantData(name: "", dateOfBirth: .now)
        
        celebrant.name = defaults.string(forKey: UserDefaultsKeys.name) ?? ""
        celebrant.dateOfBirth = defaults.value(forKey: UserDefaultsKeys.dateOfBirth) as? Date ?? Date.now
        if let fileURL {
            do {
                let imageData = try Data(contentsOf: fileURL)
                celebrant.image = UIImage(data: imageData)
            } catch {
                print("Can't load image: \(error)")
            }
        } else {
            print("Can't load image file")
        }
        
        return celebrant
    }
}
