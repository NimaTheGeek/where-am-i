//
//  ViewController.swift
//  where am i
//
//  Created by Nima Farahani on 8/8/16.
//  Copyright © 2016 Nima Farahani. All rights reserved.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var nearAddress: UILabel!
    
    
    
    var manager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //basic setup for any app using map and gps
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        self.latitude.text = "\(userLocation.coordinate.latitude)"
        self.longitude.text = "\(userLocation.coordinate.longitude)"
        self.course.text = "\(userLocation.course)"
        self.speed.text = "\(userLocation.speed)"
        self.altitude.text = "\(userLocation.altitude)"
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if let firstPlacemark = placemarks?.first where error == nil {
                
               // print(firstPlacemark)
                self.nearAddress.text = "\(firstPlacemark.thoroughfare!) \n \(firstPlacemark.subAdministrativeArea!) \n \(firstPlacemark.postalCode!) \n \(firstPlacemark.country!)"
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

