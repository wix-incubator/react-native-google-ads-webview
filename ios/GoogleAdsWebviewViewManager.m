#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(GoogleAdsWebviewViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(adHost, NSString)
RCT_EXPORT_VIEW_PROPERTY(adSlot, NSString)
RCT_EXPORT_VIEW_PROPERTY(adClient, NSString)
RCT_EXPORT_VIEW_PROPERTY(pageUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(onUnfilledAd, RCTBubblingEventBlock)

@end
