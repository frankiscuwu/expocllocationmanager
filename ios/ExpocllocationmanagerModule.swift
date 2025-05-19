import ExpoModulesCore
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate {
  weak var module: ExpocllocationmanagerModule?

  init(module: ExpocllocationmanagerModule) {
    self.module = module
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    module?.handleLocationUpdate(locations)
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    module?.handleLocationError(error)
  }
}

public class ExpocllocationmanagerModule: Module {
    private let locationManager = CLLocationManager()
    private var locationDelegate: LocationDelegate?
    private var hasListeners = false
    
  public func definition() -> ModuleDefinition {
    Name("Expocllocationmanager")
      
      OnCreate {
          let delegate = LocationDelegate(module: self)
          self.locationDelegate = delegate
          self.locationManager.delegate = delegate
      }
      
      OnStartObserving {
          self.hasListeners = true
          self.locationManager.delegate = self.locationDelegate
      }
      
      OnStopObserving {
          self.hasListeners = false
          self.locationManager.delegate = nil
      }
      
      Events("locationUpdated", "locationError")
      
      Function("getAuthorizationStatus") {
          switch self.locationManager.authorizationStatus {
          case .authorizedAlways: return "authorizedAlways"
          case .authorizedWhenInUse: return "authorizedWhenInUse"
          case .denied: return "denied"
          case .notDetermined: return "notDetermined"
          case .restricted: return "restricted"
          @unknown default: return "unknown"
          }
      }

      Function("startTracking") {
          if CLLocationManager.significantLocationChangeMonitoringAvailable() {
              self.locationManager.delegate = self.locationDelegate
              self.locationManager.startMonitoringSignificantLocationChanges()
          } else {
              if self.hasListeners {
                  self.sendEvent("locationError", [
                    "message": "Significant location change monitoring not available"
                  ])
              }
          }
      }
      
      Function("stopTracking") {
          self.locationManager.stopMonitoringSignificantLocationChanges()
      }
            
  }
    
    func handleLocationUpdate(_ locations: [CLLocation]) {
        guard hasListeners, let location = locations.last else { return }

        let locationData: [String: Any] = [
          "latitude": location.coordinate.latitude,
          "longitude": location.coordinate.longitude,
          "accuracy": location.horizontalAccuracy,
          "timestamp": location.timestamp.timeIntervalSince1970 * 1000
        ]

        sendEvent("locationUpdated", locationData)
      }

      func handleLocationError(_ error: Error) {
        if hasListeners {
          sendEvent("locationError", ["message": error.localizedDescription])
        }
      }
}
