package com.googleadswebview;

import android.webkit.CookieManager;
import android.webkit.WebView;

import androidx.annotation.NonNull;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.google.android.gms.ads.MobileAds;

public class GoogleAdsWebviewViewManager extends SimpleViewManager<WebView> {
  public static final String REACT_CLASS = "GoogleAdsWebviewView";

  private String adHost = null;
  private String adClient = null;
  private String adSlot = null;
  private String pageUrl = null;

  @Override
  @NonNull
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  @NonNull
  public WebView createViewInstance(ThemedReactContext reactContext) {
    WebView webView = new WebView(reactContext);
    WebView.setWebContentsDebuggingEnabled(true);
    webView.getSettings().setJavaScriptEnabled(true);

    MobileAds.registerWebView(webView);
    return webView;
  }

  @ReactProp(name = "adHost")
  public void adHost(WebView webview, String adHost) {
    this.adHost = adHost;
  }

  @ReactProp(name = "adClient")
  public void adClient(WebView webview, String adClient) {
    this.adClient = adClient;
  }

  @ReactProp(name = "adSlot")
  public void adSlot(WebView webview, String adSlot) {
    this.adSlot = adSlot;
  }

  @ReactProp(name = "pageUrl")
  public void pageUrl(WebView webview, String pageUrl) {
    this.pageUrl = pageUrl;
  }

  @Override
  protected void onAfterUpdateTransaction(@NonNull WebView webView) {
    super.onAfterUpdateTransaction(webView);
    String data = "<body style=\"margin: 0;\">" + "<script async\n" +
      "src=\"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js\"\n" +
      "crossorigin=\"anonymous\"></script>\n" +
      "<ins class=\"adsbygoogle\"\n" +
      "style=\"display:inline-block;width:100%;height:100%;\"\n" +
      "data-ad-client=" + this.adClient + "\n" +
      "data-ad-host=" + this.adHost + "\n" +
      "data-page-url=" + this.pageUrl + "\n" +
      "data-ad-slot=" + this.adSlot + "></ins>\n" +
      "<script>\n" +
      "(adsbygoogle = window.adsbygoogle || []).push({});\n" +
      "</script>\n" +
      "</body>";
    webView.loadDataWithBaseURL(this.pageUrl, data, "text/html", "UTF-8", null);
  }
}
