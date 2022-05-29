//
//  Routine.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import Foundation

/// Model for our application
struct Routine: Decodable, Identifiable {
    var id: Int
    var name: String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}
