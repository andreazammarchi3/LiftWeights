//
//  GetReadyView.swift
//  LiftWeights
//
//  Created by Andrea on 08/06/22.
//

import SwiftUI

struct GetReadyView: View {
    
    var routine: Routine
    
    @State var progress: Double = 0
    
    var body: some View {
        VStack {
            Text("Get Ready!")
                .font(.largeTitle)
                .bold()
            
            ZStack {
                CircularProgressView(progress: 0)
                    .frame(width: 200, height: 200)
                
                Text("\(progress * 100, specifier: "%.0f")")
                                    .font(.largeTitle)
                                    .bold()
            }.padding()
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
    }
}

/*
struct GetReadyView_Previews: PreviewProvider {
    static var previews: some View {
        GetReadyView()
    }
}
*/
