import * as React from 'react';

import { ExpocllocationmanagerViewProps } from './Expocllocationmanager.types';

export default function ExpocllocationmanagerView(props: ExpocllocationmanagerViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
