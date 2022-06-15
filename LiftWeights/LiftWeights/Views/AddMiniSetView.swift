//
//  AddMiniSetView.swift
//  LiftWeights
//
//  Created by Andrea on 15/06/22.
//

import SwiftUI

struct AddMiniSetView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @Binding var showAddMiniSetView: Bool
    
    @State private var showingAlert = false
    
    @State private var reps = ""
    
    @State private var weight = ""
    
    var routine: Routine
    
    var exercise: Exercise
    
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
                        self.showAddMiniSetView = false
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Text("Add Set")
                }.alert("Warning\n'Reps' must be integer and 'Weight' must be decimal.", isPresented: $showingAlert) {
                    Button("Ok", role: .cancel) { showingAlert = false }
                }.foregroundColor(.white)
            }.navigationTitle("Add Set")
                .navigationViewStyle(.stack)
        }
    }
}

/*
struct AddMiniSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddMiniSetView(viewModel: DataLoader(), showSettings: Binding<Bool>)
    }
}
*/
