
import UIKit
import GoogleMaps
import CoreLocation

class GoogleMapScreen: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    var currentLocation: CLLocation!
    var locationManager = CLLocationManager()
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure location manager

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //configure map view
        
        self.mapView.delegate = self
    }
    
    func showMarker() {
        marker.position = CLLocationCoordinate2D(latitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude)
        marker.isDraggable = true
        marker.map = self.mapView
    }
}

//location manager methods
extension GoogleMapScreen: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Location.sharedInstance.latitude = 28.0
        Location.sharedInstance.longitude = 77.0
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        let camera = GMSCameraPosition.camera(withLatitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude, zoom: 17.0)
        self.mapView.camera = camera
        
        showMarker()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        Location.sharedInstance.latitude = location.coordinate.latitude
        Location.sharedInstance.longitude = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        let camera = GMSCameraPosition.camera(withLatitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude, zoom: 17.0)
        self.mapView.camera = camera
        
        showMarker()
    }
}

//Google Map delegate methods
extension GoogleMapScreen: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        Location.sharedInstance.latitude = marker.position.latitude
        Location.sharedInstance.longitude = marker.position.longitude
        print(Location.sharedInstance.latitude)
        print(Location.sharedInstance.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude, zoom: 17.0)
        self.mapView.animate(to: camera)
    }
}
