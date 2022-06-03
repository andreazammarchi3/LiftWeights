//
//  RepEntity.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import Foundation
import CoreData
import SwiftUI

extension RepEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<RepEntity> {
        let request = NSFetchRequest<RepEntity>(entityName: "RepEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.predicate = predicate
        return request
    }
    
    func convertToRep() -> Rep {
        Rep(id: Int(self.id), weight: self.weight)
    }
}
