//
//  AddRoutineView.swift
//  LiftWeights
//
//  Created by Andrea on 30/05/22.
//

import SwiftUI
import CoreData

struct AddRoutineView: View {
    @State var routineName = ""
    @State var routineImage = UIImage()
    @State var isShowingImagePicker = false
    @State var imagePicked = false
    
    @ObservedObject var viewModel: DataLoader

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Routine Details")) {
                    TextField("Name", text: $routineName)
                }
                
                Section(header: Text("Routine Image")) {
                    if imagePicked {
                        HStack {
                            Spacer()
                            Image(uiImage: routineImage)
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                            Spacer()
                        }
                    }
                    Button {
                        isShowingImagePicker = true
                    } label: {
                        Text("Pick Image")
                    }.sheet(isPresented: $isShowingImagePicker) {
                        ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: $routineImage, imagePicked: $imagePicked)
                    }
                }
                
                Button {
                    let routine = Routine(id: 0, name: routineName, imagePic: routineImage, exercises: [Exercise](), image: "")
                    viewModel.addRoutine(routine: routine)
                    dismiss()
                } label: {
                    Text("Add Routine")
                }
            }.navigationTitle("Add Routine")
        }
    }
}

/*
struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView()
    }
}
*/
