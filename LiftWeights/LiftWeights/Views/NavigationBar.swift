//
//  NavigationBar.swift
//  LiftWeights
//
//  Created by Andrea on 09/06/22.
//

import SwiftUI

struct NavigationBar: View {
    
    var title: String
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.thinMaterial)
                .blur(radius: 50)
            
            Text("\(title)")
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
        }.frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Legs")
            .preferredColorScheme(.dark)
    }
}
