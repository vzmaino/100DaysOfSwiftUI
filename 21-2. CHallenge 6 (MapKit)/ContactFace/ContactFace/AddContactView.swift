//
//  AddContactView.swift
//  ContactFace
//
//  Created by Vinicius Maino on 03/04/21.
//

import SwiftUI
import CoreData

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var personName = ""
    @State private var showingImagePicker = false
    @State private var importedImage: UIImage?
    @State private var image: Image?
    @State private var currentUserImageId: UUID?
    @State var person: Person?
    
    @State private var imageSourceType: ImageSourceType = .library
    
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            
            Text("Add new contact")
                .font(.system(size: 40, weight: .bold))
                .padding()
            
            
            ZStack {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 120, height: 120, alignment: .center)
                
                if image != nil {
                    image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Capsule())
                }
            }
            
            Button("Take photo") {
                takePhoto()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(Color.black)
            .font(.system(size: 12, weight: .bold))
            .cornerRadius(25)
            
            Button("Select image from library") {
                selectPhoto()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(Color.black)
            .font(.system(size: 12, weight: .bold))
            .cornerRadius(25)
            
            TextField("Name", text: $personName)
                .padding()

            Button("SAVE") {
                let newPerson = Person(context: self.moc)
                newPerson.imageId = UUID()
                newPerson.name = self.personName
                
                if let location = self.locationFetcher.lastKnownLocation {
                    newPerson.latitude = location.latitude
                    newPerson.longitude = location.longitude
                }
                
                FileManager().savePhoto(self.importedImage!, withName: newPerson.imageId!.uuidString)
                
                try? self.moc.save()
                self.presentationMode.wrappedValue.dismiss()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(Color.black)
            .font(.system(size: 12, weight: .bold))
            .cornerRadius(25)
            
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$importedImage, sourceType: self.imageSourceType)
        }
        .onAppear() {
            self.locationFetcher.start()
        }
        
    }
    
    func takePhoto() {
        if ImagePicker.isCameraAvailable() {
            self.imageSourceType = .camera
            self.showingImagePicker = true
        }
        else {
            print("error")
        }
    }
    
    func selectPhoto() {
        self.imageSourceType = .library
        self.showingImagePicker = true
    }

    
    func loadImage() {
        guard let inputImage = importedImage else { return }
        image = Image(uiImage: inputImage)
    }

    
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
