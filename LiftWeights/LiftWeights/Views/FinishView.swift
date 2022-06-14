//
//  FinishView.swift
//  LiftWeights
//
//  Created by Andrea on 13/06/22.
//

import SwiftUI

struct FinishView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var body: some View {
        Text("Routine completed!")
            .font(.largeTitle.bold())
        ZStack {
            Button(action: {

            }, label: {
                Text("Back to HOME")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(20)
            })
        }
    }
}

/*
struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(viewModel: DataLoader())
    }
}
*/
