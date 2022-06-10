//
//  User.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct User: Decodable, Identifiable {
    var id: Int
    var nickname: String
    var imagePic: Data
    var height: Float
    var weight: Float
    var age: Int
    private var image: String
    
    init(id: Int, nickname: String, imagePic: UIImage, height: Float, weight: Float, age: Int, image: String){
        self.id = id
        self.nickname = nickname
        self.imagePic = imagePic.pngData()!
        self.height = height
        self.weight = weight
        self.age = age
        self.image = image
    }
    
    var imageUrl: URL {
        URL(string: image)!
    }
}
