//
//  BadgeView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct BadgeView: View {
    
    @State var badge: Badge
    
    var owned: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RarityView(badge: badge)
            
            VStack(alignment: .leading) {
                BadgeImage(badge: badge)
                
                Text("\(badge.title)")
                    .font(.largeTitle.bold())
                
                Text("\(badge.desc)")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }.padding(.leading, 20)
                .padding(.top, 10)
        }.opacity(owned ? 1 : 0.3)
    }
}

struct RarityView: View {
    
    @ObservedObject var viewModel = DataLoader()
    
    var badge: Badge
    
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .frame(width: 300, height: 200, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
            .onAppear {
                viewModel.loadImage(url: badge.rarityUrl)
            }
    }
}

struct BadgeImage: View {
    
    @ObservedObject var viewModel = DataLoader()
    
    var badge: Badge
    
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .frame(width: 75, height: 75, alignment: .center)
            .clipShape(Circle())
            .clipped()
            .overlay(Circle().stroke(Color(UIColor.label), lineWidth: 2))
            .onAppear {
                viewModel.loadImage(url: badge.imageUrl)
            }
    }
}

/*
struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
*/
