//
//  RoutineRowView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct RoutineRowView: View {
    @ObservedObject var viewModel: DataLoader
    var routine: Routine
    
    var body: some View {
        HStack {
            Text(String(routine.id))
                .font(.largeTitle)
                .frame(alignment: .center)
            Text(routine.name)
        }
    }
}

/*
struct RoutineRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineRowView(viewModel: <#DataLoader#>, routine: <#Routine#>)
    }
}
*/
