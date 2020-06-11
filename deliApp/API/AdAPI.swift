//
//  AdAPI.swift
//  deliApp
//
//  Created by iJPe on 29/03/20.
//  Copyright © 2020 reliae. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class AdAPI {
    typealias LoadAdsHandler = (AdsResponse?, Error?) -> Void
    
    func loadAds(on location: CLLocationCoordinate2D, completion: @escaping LoadAdsHandler) {
        let _headers = [
            "Content-Type": "application/json",
            "Authorization": "bearer \(Identity.shared.user!.serverToken!)"
        ]
        
        var _parameters = [String : Any]()
        _parameters["user_id"] = Identity.shared.user?.id
        _parameters["latitude"] = location.latitude
        _parameters["longitude"] = location.longitude
        
        Alamofire.request("\(Env.Deli.hostApi)advertises", method: .get, parameters: _parameters, headers: _headers).responseAds { (response) in
            if let response = response.result.value {
                if response.success == 0 {
                    completion(nil, ApiError.message(response.message!))
                }
                
                completion(response, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
