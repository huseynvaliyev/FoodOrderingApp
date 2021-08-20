//
//  GetLocationViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 14.08.2021.
//

import UIKit
import CoreLocation
import Firebase

class GetLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var getCurrentLocationButton: UIButton!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var doorNoTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var approveLocationButton: UIButton!
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        getCurrentLocationButton.layer.cornerRadius = 8
        streetTextField.layer.cornerRadius = 8
        districtTextField.layer.cornerRadius = 8
        townTextField.layer.cornerRadius = 8
        doorNoTextField.layer.cornerRadius = 8
        cityTextField.layer.cornerRadius = 8
        countryTextField.layer.cornerRadius = 8
        approveLocationButton.layer.cornerRadius = 8
        
        getCurrentLocationButton.layer.borderColor = UIColor(cgColor: .init(red: 23, green: 24, blue: 233, alpha: 1)).cgColor
        getCurrentLocationButton.setImage(UIImage(named: "location.fill"), for: .normal)
        getCurrentLocationButton.imageView?.contentMode = .scaleAspectFill
        getCurrentLocationButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -30, bottom: 12, right: 0)
        
    }
    
    @IBAction func getCuttentLocation(_ sender: Any) {
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let geoCoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        geoCoder.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            if error != nil {
                print("Reverse Geodcode Fail: \(error!.localizedDescription)")
            }
            let placemarkArray = placemarks! as [CLPlacemark]
            if placemarkArray.count > 0 {
                let placemark = placemarks![0]
                self.countryTextField.text = placemark.country
                self.cityTextField.text = placemark.administrativeArea
                self.districtTextField.text = placemark.locality
                self.streetTextField.text = placemark.thoroughfare
                self.doorNoTextField.text = placemark.subThoroughfare
                self.townTextField.text = placemark.subLocality
            }
        })
    }
    
    @IBAction func approveLocation(_ sender: Any) {
        let db = Firestore.firestore()
        let defaults = UserDefaults.standard
        guard let town = townTextField.text else { return }
        guard let street = streetTextField.text else { return }
        guard let district = districtTextField.text else { return }
        guard let doorNo = doorNoTextField.text else { return }
        let location = "\(street)/ \(doorNo)/ \(town)/ \(district)"
        db.collection("users").document(defaults.object(forKey: "userId") as! String).updateData(["location": location]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }

}
