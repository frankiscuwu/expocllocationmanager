import ExpocllocationmanagerModule from "./ExpocllocationmanagerModule";
import { EventSubscription } from "expo-modules-core";

export function getAuthorizationStatus(): string {
  return ExpocllocationmanagerModule.getAuthorizationStatus();
}

export function startTracking(): void {
  return ExpocllocationmanagerModule.startTracking();
}

export function stopTracking(): void {
  return ExpocllocationmanagerModule.stopTracking();
}

export function addLocationListener(listener: (location: any) => void) : EventSubscription {
  return ExpocllocationmanagerModule.addListener("locationUpdated", listener);
}

export function addLocationErrorListener(callback: (error: any) => void) : EventSubscription {
  return ExpocllocationmanagerModule.addListener("locationError", callback);
}
