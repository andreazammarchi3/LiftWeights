//
//  AddExView.swift
//  LiftWeights
//
//  Created by Andrea on 06/06/22.
//

import SwiftUI

struct AddExView: View {
    var routine: Routine
    
    @State var exName = ""
    @State var exImage = UIImage()
    @State var isShowingImagePicker = false
    @State var imagePicked = false
    
    @ObservedObject var viewModel: DataLoader

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Name", text: $exName)
                }
                
                Section(header: Text("Exercise Image")) {
                    if imagePicked {
                        HStack {
                            Spacer()
                            Image(uiImage: exImage)
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
                        ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: $exImage, imagePicked: $imagePicked)
                    }
                }
                
                Button {
                    let exercise = Exercise(id: 0, name: exName, imagePic: exImage, miniSets: [MiniSet](), image: "")
                    viewModel.addExercise(routine: routine, exercise: exercise)
                    dismiss()
                } label: {
                    Text("Add Exercise")
                }
            }.navigationTitle("Add Exercise")
        }
    }
}

/*
struct AddExView_Previews: PreviewProvider {
    static var previews: some View {
        AddExView()
    }
}
*/
