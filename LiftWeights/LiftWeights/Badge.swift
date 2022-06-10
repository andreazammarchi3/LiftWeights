//
//  Badge.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct Badge: Decodable, Identifiable {
    var id: Int
    var title: String
    var desc: String
    var rarity: String
    var image: String
    
    init(id: Int, title: String, desc: String, rarity: String, image: String){
        self.id = id
        self.title = title
        self.desc = desc
        self.rarity = rarity
        self.image = image
    }
    
    var rarityUrl: URL {
        URL(string: rarity)!
    }
    
    var imageUrl: URL {
        URL(string: image)!
    }
}
