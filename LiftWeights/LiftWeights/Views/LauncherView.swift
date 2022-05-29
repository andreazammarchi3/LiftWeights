//
//  LauncherView.swift
//  LiftWeights
//
//  Created by Andrea on 25/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct LauncherView: View {
    @State var animationFinished = false
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: ContentView()) {
                ZStack(alignment: .center) {
                    Color(red: 28/255, green: 28/255, blue: 28/255)
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("LiftWeights")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                    }
                }.ignoresSafeArea(.all)
            }.ignoresSafeArea(.all)
        }
    }
}


struct LauncherView_Previews: PreviewProvider {
    static var previews: some View {
        LauncherView()
            
    }
}
