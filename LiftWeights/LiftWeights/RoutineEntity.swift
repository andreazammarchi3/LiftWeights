//
//  RoutineEntity.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import Foundation
import CoreData

extension RoutineEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<RoutineEntity> {
        let request = NSFetchRequest<RoutineEntity>(entityName: "RoutineEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.predicate = predicate
        return request
    }
    
    func convertToRoutine() -> Routine {
        Routine(id: Int(self.id), name: self.name!)
    }
}
