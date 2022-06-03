//
//  DataLoader.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import Foundation
import SwiftUI
import CoreData

/// ViewModel
class DataLoader: UIResponder, ObservableObject{
    @Published var model = ModelData<Routine>(fileName: "routinesEmpty")
    
    var lastID: Int {
            UserDefaults.standard.integer(forKey: "lastID")
        }
    
    var routines: [Routine] {
        model.list
    }
    
    func addRoutine(routine: Routine, viewContext: NSManagedObjectContext) {
        withAnimation {
            let newRoutine = RoutineEntity(context: viewContext)
            newRoutine.id = Int64(lastID + 1)
            newRoutine.name = routine.name
            newRoutine.image = routine.image
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteRoutines(routines: [RoutineEntity], viewContext: NSManagedObjectContext) {
        withAnimation {
            for routine in routines {
                viewContext.delete(routine)
            }
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addExercise() {
        
    }
    
    func deleteExercises() {
        
    }
    
    func addRep() {
        
    }
    
    func deleteReps() {
        
    }
}
