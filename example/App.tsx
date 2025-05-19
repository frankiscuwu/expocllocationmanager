import * as ExpoCLLocationManagerModule from "expocllocationmanager";
import { Text, View } from "react-native";
import * as Location from "expo-location";
import { useEffect, useState } from "react";

export default function App() {
  const [locations, setLocations] = useState<any[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const locationUpdatedListener = ExpoCLLocationManagerModule.addLocationListener(
      (location) => {
        setLocations((prevLocations) => [...prevLocations, location]);
      }
    );

    const locationErrorListener = ExpoCLLocationManagerModule.addLocationErrorListener(
      (error) => {
        console.error("Location error:", error);
      }
    );

    return () => {
      locationUpdatedListener.remove();
      locationErrorListener.remove();
    };
  }, []);

  useEffect(() => {
    (async () => {
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== "granted") {
        console.log("Permission to access location was denied");
        return;
      }
      const { status: backgroundStatus } =
        await Location.requestBackgroundPermissionsAsync();
      if (backgroundStatus !== "granted") {
        console.log("Permission to access background location was denied");
        return;
      }
      try {
        await ExpoCLLocationManagerModule.startTracking();
      } catch (e) {
        setError(e instanceof Error ? e.message : String(e ?? "what error"));
      }
    })();
  }, []);

    return (
        <View
            style={{ flex: 1, justifyContent: "center", alignItems: "center" }}
        >
            <Text>{ExpoCLLocationManagerModule.getAuthorizationStatus()}</Text>
            <Text>Locations: {(locations.length) > 0 ? JSON.stringify(locations) : 'None'}</Text>
            <Text>{error}</Text>
        </View>
    );
}
