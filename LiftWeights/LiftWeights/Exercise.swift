//
//  Exercise.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct Exercise: Decodable, Identifiable {
    var id: Int
    var name: String
    var image: Data
    var sets: Array<Set>
    
    init(id: Int, name: String, image: UIImage, sets: Array<Set>){
        self.id = id
        self.name = name
        self.image = image.pngData()!
        self.sets = sets
    }
}
