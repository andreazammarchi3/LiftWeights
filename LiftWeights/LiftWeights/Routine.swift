//
//  Routine.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct Routine: Decodable, Identifiable {
    var id: Int
    var name: String
    var image: Data
    var exercises: Array<Exercise>
    
    init(id: Int, name: String, image: UIImage, exercises: Array<Exercise>){
        self.id = id
        self.name = name
        self.image = image.pngData()!
        self.exercises = exercises
    }
}
