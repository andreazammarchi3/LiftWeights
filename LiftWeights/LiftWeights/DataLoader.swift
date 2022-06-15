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
    @Published var model = ModelData<Routine>(fileName: "routines")
    @Published var users = ModelData<User>(fileName: "users")
    @Published var badges = ModelData<Badge>(fileName: "badges")
    @Published var workouts = ModelData<Workout>(fileName: "workouts")
    @Published var restSetTime = 29
    @Published var restExTime = 59
    @Published var getReadyTime = 14
    @Published var restTime = 14
    
    var routines: [Routine] {
        model.list
    }
    
    var purple = Color(red: 90/255, green: 60/255, blue: 137/255)
    var pink = Color(red: 208/255, green: 42/255, blue: 251/255)
    var blue = Color(UIColor.systemBlue)
    var cyan = Color(red: 38/255, green: 191/255, blue: 245/255)
    
    var lastId = 50
    
    func addRoutine(routine: Routine) {
        withAnimation {
            let newRoutine = Routine(
                id: lastId + 1,
                name: routine.name,
                imagePic: UIImage(data: routine.imagePic)!,
                exercises: [Exercise](),
                image: "https://raw.githubusercontent.com/andreazammarchi3/LiftWeights/main/Resources/cross.png")
            model.list.append(newRoutine)
            lastId += 1
        }
    }
    
    func deleteRoutines(routines: [Routine]) {
        withAnimation {
            for routine in routines {
                model.list = model.list.filter(){$0.id != routine.id}
            }
        }
    }
    
    func addExercise(routine: Routine, exercise: Exercise) {
        withAnimation {
            let newEx = Exercise(
                id: lastId + 1,
                name: exercise.name,
                imagePic: UIImage(data: exercise.imagePic)!,
                miniSets: [MiniSet](),
                image: "https://raw.githubusercontent.com/andreazammarchi3/LiftWeights/main/Resources/cross.png")
            if let fooOffset = model.list.firstIndex(where: {$0.id == routine.id}) {
                model.list[fooOffset].exercises.append(newEx)
            }
            lastId += 1
        }
    }
    
    func deleteExercises(routine: Routine, exercises: [Exercise]) {
        withAnimation {
            for exercise in exercises {
                if let fooOffset = model.list.firstIndex(where: {$0.id == routine.id}) {
                    model.list[fooOffset].exercises = model.list[fooOffset].exercises.filter() {$0.id != exercise.id}
                }
            }
        }
    }
    
    func addMiniSet(routine: Routine, exercise: Exercise, miniSet: MiniSet) {
        withAnimation {
            let newMiniSet = MiniSet(
                id: lastId + 1,
                reps: miniSet.reps,
                weight: miniSet.weight)
            if let routineOffset = model.list.firstIndex(where: {$0.id == routine.id}) {
                if let exOffset = model.list[routineOffset].exercises.firstIndex(where: {$0.id == exercise.id}) {
                    model.list[routineOffset].exercises[exOffset].miniSets.append(newMiniSet)
                }
            }
            lastId += 1
        }
    }
    
    func deleteMiniSets(routine: Routine, exercise: Exercise, miniSets: [MiniSet]) {
        withAnimation {
            for miniSet in miniSets {
                if let routineOffset = model.list.firstIndex(where: {$0.id == routine.id}) {
                    if let exOffset = model.list[routineOffset].exercises.firstIndex(where: {$0.id == exercise.id}) {
                        model.list[routineOffset].exercises[exOffset].miniSets =
                        model.list[routineOffset].exercises[exOffset].miniSets.filter() {$0.id != miniSet.id}
                    }
                }
            }
        }
    }
    
    func addWorkout(workout: Workout) {
        let newWorkout = Workout(
            id: lastId + 1,
            date: "",
            totalTime: workout.totalTime/60,
            workTime: workout.workTime/60,
            restTime: workout.restTime/60)
        lastId += 1
        self.workouts.list.append(newWorkout)
    }
    
    let notFoundImage = UIImage(systemName: "multiply.circle")
    
    @Published var images: [Int: UIImage] = [:]
    var isLoading = true
    
    func loadImage(url: URL, id: Int) {
        self.isLoading = true
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.images[id] = UIImage(data: imageData)!
                    self.isLoading = false
                }
            }
        }
    }
}
