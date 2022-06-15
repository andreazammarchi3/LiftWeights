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
                    }).foregroundColor(.white)
                }
            }.sheet(isPresented: $showAddMiniSetView, onDismiss: {
                showAddMiniSetView = false
            }, content: {
                AddMiniSetView(viewModel: viewModel, showAddMiniSetView: $showAddMiniSetView, routine: routine, exercise: exercise)
            })

            

    }
}

/*
struct ExView_Previews: PreviewProvider {
    static var previews: some View {
        ExView()
    }
}
*/
