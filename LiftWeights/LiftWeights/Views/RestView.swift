//
//  RestView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct RestView: View {
    
    @ObservedObject var viewModel: DataLoader

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            Text("RESTING...")
        }
    }
}

struct RestView_Previews: PreviewProvider {
    static var previews: some View {
        RestView(viewModel: DataLoader())
    }
}
