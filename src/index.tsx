import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-google-ads-webview' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type GoogleAdsWebviewProps = {
  adHost: string;
  adClient: string;
  pageUrl: string;
  adSlot?: string;
  onUnfilledAd?: () => void;
  style?: ViewStyle;
};

const ComponentName = 'GoogleAdsWebviewView';

export const GoogleAdsWebviewView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<GoogleAdsWebviewProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
