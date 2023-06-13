//
//  XHNLocationManager.swift
//  BBKit
//
//  Created by lk on 2023/4/4.
//

import Foundation
import CoreLocation

public class BBLocationManager: NSObject, CLLocationManagerDelegate {
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.pausesLocationUpdatesAutomatically = false
        return manager
    }()
    
    public typealias SuccessBlock = (_ location: CLLocation)->()
    public typealias FailureBlock = (_ error: Error)->()
    public typealias GeocodeBlock = (_ geocode: CLPlacemark)->()
    
    public var successBlock: SuccessBlock?
    public var failureBlock: FailureBlock?
    public var geocodeBlock: GeocodeBlock?
    
    public var isOnce = true
    
    public static let share = BBLocationManager()
    
    public func startLocation(once: Bool = true, successBlock: SuccessBlock? = nil, geocoderBlock: GeocodeBlock? = nil, failureBlock: FailureBlock? = nil) {
        self.isOnce = once
        self.locationManager.startUpdatingLocation()
        self.successBlock = successBlock
        self.geocodeBlock = geocoderBlock
        self.failureBlock = failureBlock
    }
    
    public func stopLocation() {
        locationManager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            if location.coordinate.latitude > 0 && location.coordinate.longitude > 0 {
                if isOnce {
                    stopLocation()
                }
                successBlock?(location)
                CLGeocoder().reverseGeocodeLocation(location) { marks, error in
                    if let error = error {
                        self.failureBlock?(error)
                        return
                    }
                    guard let mark = marks?.first else { return }
                    self.geocodeBlock?(mark)
                }
                if isOnce {
                    return
                }
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        failureBlock?(error)
    }

}
