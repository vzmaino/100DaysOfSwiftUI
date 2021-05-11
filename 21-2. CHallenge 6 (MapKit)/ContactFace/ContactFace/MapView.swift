//
//  MapView.swift
//  ContactFace
//
//  Created by Vinicius Maino on 04/04/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var annotation: MKPointAnnotation?

    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        if let annotation = annotation {
                    mapView.setCenter(annotation.coordinate, animated: false)
        }
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if let annotation = annotation {
            view.removeAnnotations(view.annotations)
            view.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // this is our unique identifier for view reuse
            let identifier = "Placemark"

            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                // we didn't find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

                // allow this to show pop up information
                annotationView?.canShowCallout = false

            } else {
                // we have a view to reuse, so give it the new annotation
                annotationView?.annotation = annotation
            }

            // whether it's a new view or a recycled one, send it back
            return annotationView
        }
        
    }
}
