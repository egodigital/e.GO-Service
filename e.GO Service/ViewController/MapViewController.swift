//
//  MapViewController.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Felix Wehnert. All rights reserved.
//

import UIKit
import Mapbox
import SnapKit

/**
 Hallo
 */
class MapViewController: UIViewController, MGLMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        let url = URL(string: "mapbox://styles/flashspys/cjw0y6itl2lip1cmbxdo0he15")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        mapView.setCenter(CLLocationCoordinate2D(latitude: 50.781588, longitude: 6.046536), zoomLevel: 14, animated: false)
        
        var pointAnnotations = [MGLPointAnnotation]()
        for chargeLocation in ChargeLocation.loadLocations() {
            let point = MGLPointAnnotation()
            point.coordinate = chargeLocation.coordinates.coord
            point.title = chargeLocation.name
            pointAnnotations.append(point)
        }
        
        mapView.addAnnotations(pointAnnotations)
    }
    
    // MARK: - MGLMapViewDelegate methods
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            if annotation.title == "Campus Boulevard" {
                annotationView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
                annotationView!.backgroundColor = .black
                let imageView = UIImageView(image: UIImage(named: "egologo"))
                imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
                annotationView!.addSubview(imageView)
            } else {
                
                annotationView!.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
                annotationView!.backgroundColor = UIColor.init(red: 30.0/255.0, green: 232.0/255.0, blue: 30.0/255.0, alpha: 1)
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        if annotation.title == "Campus Boulevard" {
            return CustomCalloutView(representedObject: annotation)
        }
        return nil
    }
}

//
// MGLAnnotationView subclass
class CustomAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Animate the border width in/out, creating an iris effect.
        if self.annotation?.title == "Campus Boulevard" {
            
            var animation = CABasicAnimation(keyPath: "borderWidth")
            animation.duration = 0.1
            layer.borderWidth = selected ? bounds.width / 11 : 2
            layer.add(animation, forKey: "borderWidth")
            
            animation = CABasicAnimation(keyPath: "borderColor")
            animation.duration = 0.1
            layer.borderColor = selected ? UIColor.egoBlue.cgColor : UIColor.white.cgColor
            layer.add(animation, forKey: "borderColor")
            
            
        } else {
            let animation = CABasicAnimation(keyPath: "borderWidth")
            animation.duration = 0.1
            layer.borderWidth = selected ? bounds.width / 4 : 2
            layer.add(animation, forKey: "borderWidth")
        }
    }
}
