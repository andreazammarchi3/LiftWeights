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
    
    var routines: [Routine] {
        model.list
    }
    
    func addRoutine(routine: Routine) {
        withAnimation {
            var id = 1
            if model.list.count != 0 {
                id = (model.list.last)!.id + 1
            }
            let newRoutine = Routine(
                id: id,
                name: routine.name,
                image: UIImage(data: routine.image)!,
                exercises: [Exercise]())
            model.list.append(newRoutine)
        }
    }
    
    func deleteRoutines(routines: [Routine]) {
        withAnimation {
            for routine in routines {
                model.list = model.list.filter(){$0.id != routine.id}
            }
        }
    }
    
    func deleteExercisesFromRoutine(routine: Routine, exercises: [Exercise]) {
        withAnimation {
            for exercise in exercises {
                if let fooOffset = model.list.firstIndex(where: {$0.id == routine.id}) {
                    model.list[fooOffset].exercises = model.list[fooOffset].exercises.filter() {$0.id != exercise.id}
                }
            }
        }
    }
}
