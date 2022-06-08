//
//  CircleProgressView.swift
//  LiftWeights
//
//  Created by Andrea on 06/06/22.
//

import SwiftUI

struct CircleProgressView: View {
    @Binding var isLoading: Bool
        
        var body: some View {
            if isLoading {
                ProgressView()
            }
        }
}

/*
struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView()
    }
}
*/
