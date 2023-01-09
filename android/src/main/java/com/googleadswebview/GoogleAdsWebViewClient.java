package com.googleadswebview;

import android.content.Intent;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public final class GoogleAdsWebViewClient extends WebViewClient {

  @Override
  public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
    Intent intent = new Intent(Intent.ACTION_VIEW, request.getUrl());
    view.getContext().startActivity(intent);
    return true;
  }
}
