//
//  LinearGradientView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct LinearGradientView: View {
    
    @ObservedObject var viewModel = DataLoader()
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [viewModel.cyan, viewModel.pink]), startPoint: .leading, endPoint: .trailing).clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct LinearGradientView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientView()
    }
}
