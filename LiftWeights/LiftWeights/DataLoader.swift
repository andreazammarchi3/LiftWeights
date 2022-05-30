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
    
    //MARK: -Access to model
    var routines: [Routine] {
        model.list
    }
    
    //@Published var image = UIImage()
    @Published var images: [Int: UIImage] = [:]
    var isLoading = true
    
    //MARK: -Utilities
    /*func loadImage(imageName: String) {
        image = UIImage(named: imageName)!
        self.isLoading = false
    }
    
    func loadImage(url:URL) {
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.image = UIImage(data: imageData)!
                    self.isLoading = false
                }
            }
        }
    }*/
    
    let notFoundImage = UIImage(systemName: "multiply.circle")
    
    func loadImage(url:URL, id: Int) {
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
    
    func addRoutine(routine: Routine, viewContext: NSManagedObjectContext) {
        withAnimation {
            let newRoutine = RoutineEntity(context: viewContext)
            newRoutine.id = Int64(lastID + 1)
            newRoutine.name = routine.name
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(routines: [RoutineEntity], viewContext: NSManagedObjectContext) {
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
}
