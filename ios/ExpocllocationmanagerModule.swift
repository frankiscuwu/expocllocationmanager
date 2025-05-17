import ExpoModulesCore
import CoreLocation

public class ExpocllocationmanagerModule: Module {
    private let locationManager = CLLocationManager()
    private var hasListeners = false
    
  public func definition() -> ModuleDefinition {
    Name("Expocllocationmanager")
      
      OnStartObserving {
          self.hasListeners = true
      }
      
      OnStopObserving {
          self.hasListeners = false
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
}
