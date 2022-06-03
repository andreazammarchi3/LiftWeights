//
//  Set.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct Set: Decodable, Identifiable {
    var id: Int
    var reps: Int
    var weight: Float
    
    init(id: Int, reps: Int, weight: Float){
        self.id = id
        self.reps = reps
        self.weight = weight
    }
}
