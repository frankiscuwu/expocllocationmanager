import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpocllocationmanagerViewProps } from './Expocllocationmanager.types';

const NativeView: React.ComponentType<ExpocllocationmanagerViewProps> =
  requireNativeView('Expocllocationmanager');

export default function ExpocllocationmanagerView(props: ExpocllocationmanagerViewProps) {
  return <NativeView {...props} />;
}
