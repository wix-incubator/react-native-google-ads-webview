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
        
        let adScriptSring = """
        <head>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
        </head>
        <body style="margin: 0;">
        <script async
        src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"
        crossorigin="anonymous"></script>
        <ins class="adsbygoogle"
        style="display:inline-block;width:100%;height:100%;"
        data-ad-client="\(self.adClient!)"
        data-ad-host="\(self.adHost!)"
        data-page-url="\(self.pageUrl!)"
        data-ad-slot="\(self.adSlot!)"></ins>
        <script>
        (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
        <body>
"""
        
        let baseURL = URL(string: self.pageUrl)
        webView.loadHTMLString(adScriptSring, baseURL: baseURL)
    }
    
    private func setupView() {
        webView = WKWebView()
        webView.navigationDelegate = self;
        
        self.addSubview(webView)
        
        GADMobileAds.sharedInstance().register(webView)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if (navigationAction.navigationType != WKNavigationType.linkActivated){
            decisionHandler(.allow)
            return;
        }
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        decisionHandler(.cancel)
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
}

