import UIKit
import WebKit
import GoogleMobileAds

class GoogleAdsWebviewView : UIView, WKNavigationDelegate, WKScriptMessageHandler {
    @objc var webView: WKWebView!
    @objc var adHost: String!
    @objc var adSlot: String!
    @objc var adClient: String!
    @objc var pageUrl: String!
    @objc var onUnfilledAd: RCTBubblingEventBlock?
    
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
        let isSetAllRequiredProps = self.adHost != nil && self.adClient != nil && self.pageUrl != nil;
        
        if (isSetAllRequiredProps){
            let adScriptString = prepareAdWebViewScriptString()
            let baseURL = URL(string: self.pageUrl)
            webView.loadHTMLString(adScriptString, baseURL: baseURL)
        }
    }
    
    private func prepareAdWebViewScriptString() -> String {
        return """
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
                \((self.adSlot != nil) ? "data-ad-slot=\"" + self.adSlot : "")"></ins>
                <script>
                (adsbygoogle = window.adsbygoogle || []).push({});
        
                //handle unfilled ad
                const callback = (mutationList, observer) => {
                for (const mutation of mutationList) {
                  if (mutation.type === 'attributes') {
                    if (mutation.attributeName === 'data-ad-status') {
                      const adStatus = mutation.target.getAttribute('data-ad-status');
                      if (adStatus === 'unfilled') {
                        window.webkit.messageHandlers.postMessageListener.postMessage('unfilled')
                      }
                    }
                  }
                }
                };
        
                const observer = new MutationObserver(callback);
                const adInsNode = document.getElementsByClassName('adsbygoogle')[0];
                const config = { attributes: true };
                observer.observe(adInsNode, config);
                </script>
                <body>
        """
    }
    
    private func setupView() {
        webView = WKWebView()
        webView.navigationDelegate = self;
        webView.configuration.userContentController.add(self, name: "postMessageListener")
        
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
    
    @objc(userContentController:didReceiveScriptMessage:) func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "postMessageListener" {
            if (message.body as? String == "unfilled"){
                self.onUnfilledAd?(nil)
            }
        }
    }
}

