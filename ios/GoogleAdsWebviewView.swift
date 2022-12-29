import UIKit
import WebKit
import GoogleMobileAds

class GoogleAdsWebviewView : UIView, WKNavigationDelegate {
    @objc var webView: WKWebView!
    @objc var adHost: String!
    @objc var adSlot: String!
    @objc var adClient: String!
    @objc var pageUrl: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        webView?.frame = self.bounds
    }
    
    override func didSetProps(_ changedProps: [String]!) {
                let myURL = URL(string: "https://webview-api-for-ads-test.glitch.me/")
//        let myURL = URL(string: self.pageUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    private func setupView() {
        webView = WKWebView()
        webView.navigationDelegate = self;
        
        self.addSubview(webView)
        
        GADMobileAds.sharedInstance().register(webView)
    }
    
    
    
}
