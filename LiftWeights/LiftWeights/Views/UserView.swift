//
//  UserView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var showSettings = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("User Details")
                    .font(.title.bold())
                
                HStack(alignment: .center) {
                    
                    ZStack(alignment: .center) {
                        Circle()
                            .background(LinearGradientView(viewModel: viewModel, radius: 20))
                            .foregroundColor(.clear)
                            .frame(width: 100, height: 100, alignment: .center)
                            .shadow(radius: 10)
                            .clipShape(Circle())
                            .clipped()
                        Image(uiImage: viewModel.images[viewModel.users.list[0].id] ?? viewModel.notFoundImage!)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .clipped()
                            .overlay(Circle().stroke(Color(UIColor.label), lineWidth: 5))
                            .onAppear {
                                if viewModel.users.list[0].id <= 41 {
                                    viewModel.loadImage(url: viewModel.users.list[0].imageUrl, id: viewModel.users.list[0].id)
                                } else {
                                    viewModel.images[viewModel.users.list[0].id] = UIImage(data: viewModel.users.list[0].imagePic)!
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
                                
                                Text("\(viewModel.users.list[0].nickname)")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Height:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(Utils.formatted(input: viewModel.users.list[0].height))cm")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Weight:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(Utils.formatted(input: viewModel.users.list[0].weight))kg")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Age:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(viewModel.users.list[0].age)")
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
                        ForEach(viewModel.users.list[0].badgesOwned, id: \.self) { badgeOwned in
                            if let fooOffset = viewModel.badges.list.firstIndex(where: {$0.id == badgeOwned}) {
                                BadgeView(viewModel: viewModel, badge: viewModel.badges.list[fooOffset], owned: true)
                            }
                            
                        }
                        ForEach(viewModel.badges.list) {badge in
                            if viewModel.users.list[0].badgesOwned.contains(badge.id) == false {
                                BadgeView(viewModel: viewModel, badge: badge, owned: false)
                            }
                        }
                    }
                }
                
                Spacer()
            }.navigationTitle("Hi \(viewModel.users.list[0].nickname)!")
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
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: DataLoader())
    }
}
