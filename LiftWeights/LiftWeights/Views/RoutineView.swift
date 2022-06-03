//
//  RoutineView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct RoutineView: View {
    var routine: Routine
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Button {
                        
                    } label: {
                        Text("Start Routine")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
                List {
                    Text("List")
                }
            }
        }.navigationTitle(routine.name)
    }
}

/*
struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
*/
