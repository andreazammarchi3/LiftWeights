//
//  ExView.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import SwiftUI

struct ExView: View {
    var exercise: Exercise
    
    var body: some View {
        Text(exercise.name)
    }
}

/*
struct ExView_Previews: PreviewProvider {
    static var previews: some View {
        ExView()
    }
}
*/
