//
//  Tabbar.swift
//  GoTraveller
//
//  Created by 曹越程 on 2023/1/19.
//

import SwiftUI
import PhotosUI

struct Tabbar: View {
    @State var selected = 0;
    @State var photoIndex = 0;
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var userSwiping: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: [UIImage] = []
    @State var any = PHPickerConfiguration()
    
    var body: some View {
        VStack(){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 4){
                    ForEach(image, id: \.self) {
                        photo in Image(uiImage: photo)
                            .resizable()
                            .frame(width: 400, height: 400)
                    }
                }
            }
            //.offset(x: self.userSwiping ? self.offset: CGFloat(self.))
            .frame(width: 400, alignment: .leading)
            HStack(){
                Spacer()
                Button{
                    selected = 0
                }label: {
                    Text("Story")
                        .fontWeight(selected == 0 ? .bold:.regular)
                        .foregroundColor(selected == 0 ? .black: .gray)
                }
                Spacer()
                
                Button{
                    self.showSheet = true
                }label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal,20)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .onTapGesture {
                }
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Select Photo"),
                                message: Text("Choose"), buttons: [
                                    .default(Text("Photo Library")){
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                        self.any.filter = .images
                                    },
                                    .default(Text("Camera")){
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                    },
                                    .cancel()
                                ])
                }
                Spacer()
                
                Button{
                    selected = 1
                }label: {
                    Text("Plan")
                        .fontWeight(selected == 1 ? .bold:.regular)
                        .foregroundColor(selected == 1 ? .black: .gray)
                }
                Spacer()
                
            }
            .sheet(isPresented: $showImagePicker){
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            }
            .padding(8)
            .background(Color.white)
        }
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
