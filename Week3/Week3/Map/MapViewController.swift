//
//  MapViewController.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 8.07.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userAddress: UILabel!

    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userAddress.numberOfLines = 5
        checkLocationServices()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showUserLocationInCenterMap() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            print("konum alınamıyor")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
        trackingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
            break
        }
    }
    
    func trackingLocation() {
        mapView.showsUserLocation = true
        showUserLocationInCenterMap()
        locationManager.startUpdatingLocation()
        lastLocation = getCenterLocation(mapView: mapView)
    }
    
    func getCenterLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let center = getCenterLocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        
        guard let lastLocation = lastLocation else { return }
        
        guard center.distance(from: lastLocation) > 30 else { return }
        self.lastLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            
            guard let self = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            let subThoroughfare = placemark.subThoroughfare ?? ""
            let street = placemark.thoroughfare ?? ""
            let subLocality = placemark.subLocality ?? ""
            let city = placemark.locality ?? ""
            let administrativeArea = placemark.administrativeArea ?? ""
            let country = placemark.country ?? ""
            
            self.userAddress.text = "\(subThoroughfare) - \(street) - \(subLocality) - \(city) - \(administrativeArea) - \(country)"
        }
    }
    
}
