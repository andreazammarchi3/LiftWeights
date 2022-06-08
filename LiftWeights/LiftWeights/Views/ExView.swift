//
//  ExView.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import SwiftUI

struct ExView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var routine: Routine
    
    var exercise: Exercise
    
    @State var showAddMiniSetView = false
    @State private var showingAlert = false
    @State var reps = ""
    @State var weight = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            ForEach(exercise.miniSets) { miniSet in
                MiniSetRowView(miniSet: miniSet)
            }.onDelete { indexSet in
                var miniSetsToRemove = [MiniSet]()
                for indexToRemove in indexSet {
                    miniSetsToRemove.append(contentsOf: exercise.miniSets.filter { item in
                        item.id == exercise.miniSets[indexToRemove].id
                    })
                }
                viewModel.deleteMiniSets(routine: routine, exercise: exercise, miniSets: miniSetsToRemove)
            }
        }.navigationTitle(exercise.name)
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAddMiniSetView = true
                    }, label: {
                        Label("Add MiniSet", systemImage: "plus")
                    })
                }
            }.sheet(isPresented: $showAddMiniSetView) {
                
            } content: {
                // AddMiniSetView(routine: routine, exercise: exercise, viewModel: viewModel)
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
                        .navigationViewStyle(.stack)
                }
            }

            

    }
}

/*
struct ExView_Previews: PreviewProvider {
    static var previews: some View {
        ExView()
    }
}
*/
