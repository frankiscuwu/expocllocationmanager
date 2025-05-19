//
//  LocationAppDelegateSubscriber.swift
//  Expocllocationmanager
//
//  Created by Frank Yang on 5/17/25.
//

import ExpoModulesCore
import CoreLocation

public class LocationAppDelegateSubscriber: ExpoAppDelegateSubscriber {
  private let locationManager = CLLocationManager()
    


  public func applicationDidBecomeActive(_ application: UIApplication) {
    if CLLocationManager.significantLocationChangeMonitoringAvailable() {
      locationManager.startMonitoringSignificantLocationChanges()
    }
  }

  public func applicationDidEnterBackground(_ application: UIApplication) {
    print("App entered background")
  }

  public func applicationWillTerminate(_ application: UIApplication) {
    locationManager.stopMonitoringSignificantLocationChanges()
    print("App will terminate")
  }
}
