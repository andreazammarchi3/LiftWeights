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
    var imagePic: Data
    var exercises: Array<Exercise>
    private var image: String
    
    init(id: Int, name: String, imagePic: UIImage, exercises: Array<Exercise>, image: String){
        self.id = id
        self.name = name
        self.imagePic = imagePic.pngData()!
        self.exercises = exercises
        self.image = image
    }
    
    var imageUrl: URL {
        URL(string: image)!
    }
}
