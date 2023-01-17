import * as React from 'react';

import { StyleSheet, SafeAreaView, Text } from 'react-native';
import { GoogleAdsWebviewView } from 'react-native-google-ads-webview';

const TEST_AD_PROPS = {
  adHost: 'ca-host-pub-should-generated-by-google',
  googleTestAdClient: 'ca-pub-9952238966586479',
  googleTestAdPageUrl: 'https://amirhr.com/',
};

export default function App() {
  const [isUnfilledAd, setIsUnfilledAd] = React.useState(false);

  const handleUnfilledAd = () => {
    setIsUnfilledAd(true);
  };

  return (
    <SafeAreaView style={styles.container}>
      <Text>Top Content</Text>
      {!isUnfilledAd && (
        <GoogleAdsWebviewView
          style={{ width: 300, height: 250 }}
          adHost={TEST_AD_PROPS.adHost}
          adClient={TEST_AD_PROPS.googleTestAdClient}
          pageUrl={TEST_AD_PROPS.googleTestAdPageUrl}
          onUnfilledAd={handleUnfilledAd}
        />
      )}
      <Text>Bottom Content</Text>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
