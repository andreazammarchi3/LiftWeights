//
//  ExEntity.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import Foundation
import CoreData
import SwiftUI

extension ExEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<ExEntity> {
        let request = NSFetchRequest<ExEntity>(entityName: "ExEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.predicate = predicate
        return request
    }
    
    func convertToExercise() -> Exercise {
        Exercise(id: Int(self.id), name: self.name!, image: UIImage(data: self.image!)!)
    }
}
