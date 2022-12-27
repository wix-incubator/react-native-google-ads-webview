import UIKit
import WebKit

class GoogleAdsWebviewView : UIView {
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
        let myURL = URL(string: self.pageUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    private func setupView() {
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        
        webView = WKWebView()
        webView.load(myRequest)
        
        self.addSubview(webView)
    }
    
    
    
}
