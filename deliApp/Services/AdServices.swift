//
//  AdServices.swift
//  deliApp
//
//  Created by iJPe on 29/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import CoreLocation

class AdServices {
    static func loadAds(on location: CLLocationCoordinate2D, successHandler: @escaping (([Ad]) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        API.ad.loadAds(on: location) { (adsResponse, error) in
            if let e = error {
                errorHandler(e)
            } else {
                successHandler(adsResponse!.advertises!)
            }
        }
    }
}
