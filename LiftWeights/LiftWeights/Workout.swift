//
//  Workout.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import Foundation
import UIKit
import SwiftUI

/// Model for our application
struct Workout: Decodable, Identifiable {
    var id: Int
    var date: String
    var totalTime: Int
    var workTime: Int
    var restTime: Int
    var routineId: Int
    
    init(id: Int, date: String, totalTime: Int, workTime: Int, restTime: Int, routineId: Int){
        self.id = id
        self.date = date
        self.totalTime = totalTime
        self.workTime = workTime
        self.restTime = restTime
        self.routineId = routineId
    }
}
