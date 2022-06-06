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
    var miniSets: Array<MiniSet>
    var imageURL: Optional<String>
    
    init(id: Int, name: String, image: UIImage, miniSets: Array<MiniSet>){
        self.id = id
        self.name = name
        self.image = image.pngData()!
        self.miniSets = miniSets
        self.imageURL = nil
    }
    
    var imageUrl: URL {
        URL(string: imageURL!)!
    }
    
    mutating func setImageUrl(url: URL) {
        self.imageURL = url.absoluteString
    }
}
