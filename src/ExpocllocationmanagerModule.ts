import { requireNativeModule } from 'expo-modules-core';

interface ExpocllocationmanagerModule {
  getAuthorizationStatus(): string;
  startTracking(): void;
  stopTracking(): void;
}

export default requireNativeModule<ExpocllocationmanagerModule>('Expocllocationmanager');
