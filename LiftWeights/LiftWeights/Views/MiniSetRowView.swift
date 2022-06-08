//
//  MiniSetRowView.swift
//  LiftWeights
//
//  Created by Andrea on 04/06/22.
//

import SwiftUI

struct MiniSetRowView: View {
    
    var miniSet: MiniSet
    
    var body: some View {
        Text(String(miniSet.reps) + " x " + String(miniSet.weight) + "kg")
    }
}

/*
struct MiniSetRowView_Previews: PreviewProvider {
    static var previews: some View {
        MiniSetRowView()
    }
}
*/
