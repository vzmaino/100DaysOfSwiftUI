//
//  DetailView.swift
//  ContactFace
//
//  Created by Vinicius Maino on 03/04/21.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    var person: Person
    @State private var importedImage: UIImage?
    @State private var image: Image?
    @State private var currentUserImageId: UUID?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Name: \(person.name!)")
                
                self.loadUserImage(uuid: person.imageId!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                
                MapView(annotation: getAnnotation())
            }
        }
    }
    
    func loadUserImage(uuid: UUID) -> Image {
        if let uiImage = FileManager().loadPhoto(withName: uuid.uuidString){
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
    
    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
        return annotation
    }
}
