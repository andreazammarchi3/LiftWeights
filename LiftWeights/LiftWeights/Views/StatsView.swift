//
//  StatsView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        ZStack {
            Image(systemName: "chart.xyaxis.line")
                .font(.system(size: 100))
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
