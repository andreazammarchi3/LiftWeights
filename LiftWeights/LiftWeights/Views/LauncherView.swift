//
//  LauncherView.swift
//  LiftWeights
//
//  Created by Andrea on 25/05/22.
//

import SwiftUI

struct LauncherView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("icon")
                .resizable()
                .frame(width: 150, height: 150)
            Text("LiftWeights")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}


struct LauncherView_Previews: PreviewProvider {
    static var previews: some View {
        LauncherView()
    }
}
