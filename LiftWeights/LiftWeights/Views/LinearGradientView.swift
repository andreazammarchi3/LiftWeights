//
//  LinearGradientView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct LinearGradientView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var radius: Int
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [viewModel.cyan, viewModel.pink]), startPoint: .topLeading, endPoint: .bottomTrailing).clipShape(RoundedRectangle(cornerRadius: CGFloat(radius), style: .continuous))
    }
}

/*
struct LinearGradientView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientView()
    }
}
*/
