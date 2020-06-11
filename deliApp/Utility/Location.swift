//
//  Location.swift
//  deliApp
//
//  Created by iJPe on 5/1/19.
//  Copyright © 2019 reliae. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static let shared: Location = { return Location() }()
    
    var last: CLLocation!
    
    static func getAddressFrom(_ location: CLLocation, completion: @escaping (_ address: LocationAddress?) -> Void) {
        var locationAddress = LocationAddress()
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if error == nil && placemarks!.count > 0 {
                let pm = placemarks?[0]
                
                if pm!.thoroughfare != nil {
                    locationAddress.address1 = pm!.thoroughfare! + " "
                }
                if pm!.subThoroughfare != nil {
                    locationAddress.address2 = pm!.subThoroughfare! + " "
                }
                if pm!.locality != nil {
                    locationAddress.city = pm!.locality!
                }
                if pm!.administrativeArea != nil {
                    locationAddress.state = pm!.administrativeArea!
                }
                if pm!.postalCode != nil {
                    locationAddress.postalCode = pm!.postalCode!
                }
                
                locationAddress.address = "\(locationAddress.address1!) \(locationAddress.address2!), \(locationAddress.city!), \(locationAddress.state!)"
                
                completion(locationAddress)
            }
        })
    }
    
    static func getAddressFrom(latitude: Double, longitude: Double, completion: @escaping (_ address: LocationAddress?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        Location.getAddressFrom(location) { (locationAddress) in
            completion(locationAddress)
        }
    }
}
