import { registerWebModule, NativeModule } from 'expo';

import { ExpocllocationmanagerModuleEvents } from './Expocllocationmanager.types';

class ExpocllocationmanagerModule extends NativeModule<ExpocllocationmanagerModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpocllocationmanagerModule, 'ExpocllocationmanagerModule');
