//
//  BadgeView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct BadgeView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var badge: Badge
    var rarityBack: UIImage
    
    init(viewModel: DataLoader, badge: Badge) {
        self.viewModel = viewModel
        self.badge = badge
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: badge.rarityUrl)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.rarityBack = UIImage(data: imageData)!
                } else {
                    self.rarityBack = UIImage()
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: rarityBack)
                .resizable()
                .frame(width: 300, height: 200, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
            
            /*
            Image(uiImage: loadImage(url: badge.imageUrl))
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
            */
        }.onAppear {
            viewModel.loadImage(url: badge.rarityUrl)
        }
    }
    
    private func loadImage(url: URL) -> UIImage {
        var image = UIImage()
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    image = UIImage(data: imageData)!
                }
            }
        }
        return image
    }
}

/*
struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
*/
