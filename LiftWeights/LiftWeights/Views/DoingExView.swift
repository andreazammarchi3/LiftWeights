//
//  DoingExView.swift
//  LiftWeights
//
//  Created by Andrea on 09/06/22.
//

import SwiftUI

struct DoingExView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var body: some View {
        ZStack {
            Text("Doing exercise").font(.largeTitle)
        }
    }
}

/*
struct DoingExView_Previews: PreviewProvider {
    static var previews: some View {
        DoingExView()
    }
}
*/
