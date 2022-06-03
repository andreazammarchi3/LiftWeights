//
//  Rep.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct Rep: Decodable, Identifiable {
    var id: Int
    var weight: Float
    
    init(id: Int, weight: Float){
        self.id = id
        self.weight = weight
    }
}
