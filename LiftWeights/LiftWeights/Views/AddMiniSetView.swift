//
//  AddMiniSetView.swift
//  LiftWeights
//
//  Created by Andrea on 08/06/22.
//

import SwiftUI

struct AddMiniSetView: View {
    var routine: Routine
    var exercise: Exercise
    
    @State var reps = ""
    @State var weight = ""
    @State private var showingAlert = false
    
    @ObservedObject var viewModel: DataLoader

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Set Details")) {
                    TextField("Reps", text: $reps)
                        .padding()
                        .keyboardType(.numberPad)
                    
                    TextField("Weight", text: $weight)
                        .padding()
                        .keyboardType(.decimalPad)
                }
                
                Button {
                    if Int(reps) != nil && Float(weight) != nil {
                        let miniSet = MiniSet(id: 0, reps: Int(reps)!, weight: Float(weight)!)
                        viewModel.addMiniSet(routine: routine, exercise: exercise, miniSet: miniSet)
                        dismiss()
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Text("Add Set")
                }.alert("Warning\n'Reps' must be integer and 'Weight' must be decimal.", isPresented: $showingAlert) {
                    Button("Ok", role: .cancel) { showingAlert = false }
                }
            }.navigationTitle("Add Set")
        }
    }
}

/*
struct AddMiniSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddMiniSetView()
    }
}
*/
