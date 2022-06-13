//
//  UserView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var user: User
    
    @State var showSettings = false
    
    init(viewModel: DataLoader) {
        self.viewModel = viewModel
        self.user = viewModel.users.list.first!
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("User Details")
                    .font(.title.bold())
                
                HStack(alignment: .center) {
                    
                    ZStack(alignment: .center) {
                        Circle()
                            .background(LinearGradientView(radius: 20))
                            .foregroundColor(.clear)
                            .frame(width: 100, height: 100, alignment: .center)
                            .shadow(radius: 10)
                            .clipShape(Circle())
                            .clipped()
                        Image(uiImage: viewModel.images[user.id] ?? viewModel.notFoundImage!)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .clipped()
                            .overlay(Circle().stroke(Color(UIColor.label), lineWidth: 5))
                            .onAppear {
                                if user.id <= 41 {
                                    viewModel.loadImage(url: user.imageUrl, id: user.id)
                                } else {
                                    viewModel.images[user.id] = UIImage(data: user.imagePic)!
                                }
                            }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(UIColor.systemFill))
                            .frame(height: 110, alignment: .center)
                        
                        VStack {
                            HStack(alignment: .center) {
                                Text("Nickname:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(user.nickname)")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Height:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(formatted(input: user.height))cm")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Weight:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(formatted(input: user.weight))kg")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Age:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(user.age)")
                            }
                        }.padding(.leading, 10)
                            .padding(.trailing, 10)
                    }.padding(.leading, 10)
                }
                                
                Text("Badges")
                    .font(.title.bold())
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.badgesOwned, id: \.self) { badgeOwned in
                            if let fooOffset = viewModel.badges.list.firstIndex(where: {$0.id == badgeOwned}) {
                                BadgeView(badge: viewModel.badges.list[fooOffset], owned: true)
                            }
                            
                        }
                        ForEach(viewModel.badges.list) {badge in
                            if user.badgesOwned.contains(badge.id) == false {
                                BadgeView(badge: badge, owned: false)
                            }
                        }
                    }
                }
                
                Spacer()
            }.navigationTitle("Hi \(user.nickname)!")
                .padding(10)
                .toolbar {
                        ToolbarItem {
                            Button(action: {
                                showSettings = true
                            }, label: {
                                Label("Settings", systemImage: "gear")
                            }).foregroundColor(.white)
                        }
                    }
                    .sheet(isPresented: $showSettings, onDismiss: {
                        showSettings = false
                    }, content: {
                        SettingsView(viewModel: viewModel, showSettings: $showSettings)
                    })
        }
    }
    
    private func formatted(input: Float) -> String {
        let res = String(format: "%.1f", input)
        return res
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: DataLoader())
    }
}
