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
    // Optionally stop or reduce location updates when app goes background
    // For SLC, often you can keep it running to save power
    // But you can customize if needed
  }

  public func applicationWillTerminate(_ application: UIApplication) {
    locationManager.stopMonitoringSignificantLocationChanges()
  }
}
