//
//  ViewController.swift
//  google maps
//
//  Created by Usman Mukhtar on 06/07/2020.
//  Copyright © 2020 Usman Mukhtar. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var zoom:Float = 15
    
    let lat = -23.562573
    let long = -46.654952
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMapView()
        addMarker()
        
        self.mapView.mapStyle(withFilename: "darkMap", andType: "json")
        
    }


    func createMapView(){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: zoom)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
    }
    
    func addMarker(){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.title = "Something"
        marker.snippet = "description"
        marker.map = mapView
        marker.icon = UIImage(named: "burger")
    }
    
    
    @IBAction func btnZoomIn(_ sender: UIButton) {
        zoom = zoom + 1
        self.mapView.animate(toZoom: zoom)
    }
    @IBAction func btnZoomOut(_ sender: UIButton) {
        zoom = zoom - 1
        self.mapView.animate(toZoom: zoom)
    }
    @IBAction func btnMyLocation(_ sender: UIButton) {
        guard let lat = self.mapView.myLocation?.coordinate.latitude, let lng = self.mapView.myLocation?.coordinate.longitude else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: zoom)
        self.mapView.animate(to: camera)
        
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let userLocation = GMSMarker(position: position)
        userLocation.map = mapView
    }
}

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }else {
                NSLog("Unable to find darkMap")
            }
        }
        catch {
            NSLog("failded to load. \(error)")
        }
    }
}


