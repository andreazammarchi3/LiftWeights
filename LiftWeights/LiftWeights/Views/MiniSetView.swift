//
//  MiniSetView.swift
//  LiftWeights
//
//  Created by Andrea on 04/06/22.
//

import SwiftUI

struct MiniSetView: View {
    var miniSet: MiniSet
    
    var body: some View {
        Text("Reps: " + String(miniSet.reps))
        Text("Weight: " + String(miniSet.weight))
    }
}

/*
struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SetView()
    }
}
*/
