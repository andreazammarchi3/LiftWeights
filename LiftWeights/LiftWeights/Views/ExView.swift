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
    
    var body: some View {
        List {
            ForEach(exercise.miniSets) { miniSet in
                NavigationLink(destination: MiniSetView(miniSet: miniSet)) {
                    MiniSetRowView(viewModel: viewModel, miniSet: miniSet)
                }
            }.onDelete { indexSet in
                var miniSetsToRemove = [MiniSet]()
                for indexToRemove in indexSet {
                    miniSetsToRemove.append(contentsOf: exercise.miniSets.filter { item in
                        item.id == exercise.miniSets[indexToRemove].id
                    })
                }
                viewModel.deleteMiniSets(routine: routine, exercise: exercise, miniSets: miniSetsToRemove)
            }
        }.navigationTitle(exercise.name).font(.title3)
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        
                    }, label: {
                        Text("Add MiniSet")
                    })
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
