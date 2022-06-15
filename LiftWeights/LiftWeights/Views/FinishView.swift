//
//  FinishView.swift
//  LiftWeights
//
//  Created by Andrea on 13/06/22.
//

import SwiftUI
import ConfettiSwiftUI

struct FinishView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    let routineName: String
    
    @State private var counter: Int = 0
    
    var body: some View {
        Text("Routine completed!")
            .font(.largeTitle.bold())
            .confettiCannon(counter: $counter, repetitions: 5, repetitionInterval: 1)
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.systemBlue))
                .frame(width: 170, height: 50, alignment: .center)
                .onTapGesture {
                    NavigationUtil.popToRootView()
                }
            
            Button(action: {
                //self.rootPresentationMode.wrappedValue.dismiss()
                NavigationUtil.popToRootView()
            }, label: {
                Text("Back to HOME")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(20)
            })
        }.onAppear {
            counter += 1
            viewModel.checkMissionsComplete()
        }.navigationTitle(routineName)
    }
    
}


struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(viewModel: DataLoader(), routineName: "Arms")
            .preferredColorScheme(.dark)
    }
}

