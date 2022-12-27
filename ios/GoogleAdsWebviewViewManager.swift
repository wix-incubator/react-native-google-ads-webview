@objc(GoogleAdsWebviewViewManager)
class GoogleAdsWebviewViewManager: RCTViewManager {
    
    override func view() -> GoogleAdsWebviewView {
        return GoogleAdsWebviewView()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
