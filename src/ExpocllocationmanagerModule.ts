import { NativeModule, requireNativeModule } from 'expo';

import { ExpocllocationmanagerModuleEvents } from './Expocllocationmanager.types';

declare class ExpocllocationmanagerModule extends NativeModule<ExpocllocationmanagerModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpocllocationmanagerModule>('Expocllocationmanager');
