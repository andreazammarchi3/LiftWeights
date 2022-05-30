//
//  AddRoutineView.swift
//  LiftWeights
//
//  Created by Andrea on 30/05/22.
//

import SwiftUI

struct AddRoutineView: View {
    @State var routineName = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: DataLoader

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Routine Details")) {
                    TextField("Name", text: $routineName)
                    
                }
                
                Button {
                    let routine = Routine(id: 0, name: routineName)
                    
                    viewModel.addRoutine(routine: routine, viewContext: viewContext)
                    dismiss()
                } label: {
                    Text("Add Routine")
                }
            }.navigationTitle("Add Routine")
        }
    }
}

/*
struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView()
    }
}
*/
