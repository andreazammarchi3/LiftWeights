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
    
    func addRoutine(viewContext: NSManagedObjectContext) {
        withAnimation {
            let newRoutine = RoutineEntity(context: viewContext)
            /*
             TO-DO: ROUTINE ID PICKER
             */
            let alertNameController = UIAlertController(title: "New Routine", message: "Insert Routine name", preferredStyle: .alert)
            
            alertNameController.addTextField { (textField) in
                textField.placeholder = "Name"
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                let inputName = alertNameController.textFields![0].text
                newRoutine.name = inputName
                newRoutine.id = 3
            }
            
            alertNameController.addAction(cancelAction)
            alertNameController.addAction(saveAction)
            if let vc = self.next(ofType: UIViewController.self) {
                vc.present(alertNameController, animated: true, completion: nil)
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
