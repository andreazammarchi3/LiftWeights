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
    var imagePic: Data
    var miniSets: Array<MiniSet>
    var image: String
    
    init(id: Int, name: String, imagePic: UIImage, miniSets: Array<MiniSet>, image: String){
        self.id = id
        self.name = name
        self.imagePic = imagePic.pngData()!
        self.miniSets = miniSets
        self.image = image
    }
    
    var imageUrl: URL {
        URL(string: image)!
    }
}
