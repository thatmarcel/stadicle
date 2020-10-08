#import <WebKit/WebKit.h>
#import "GamepadSupport.h"
#import "WebViewScriptMessageHandler.h"

%hook WKWebView
    - (NSString*) customUserAgent {
        return @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36";
    }

    - (NSString*) _userAgent {
        return @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36";
    }

    - (instancetype) initWithFrame:(CGRect)rect configuration:(WKWebViewConfiguration*)config {
        WKWebViewConfiguration* newConfig = [config copy];

        WebViewScriptMessageHandler *handler = [[WebViewScriptMessageHandler alloc] init];

        [newConfig.userContentController addScriptMessageHandler: handler name: @"controller"];
        self = %orig(rect, newConfig);

        handler.webView = self;

        return self;
    }
%end

%hook TabDocument
    - (void) webView:(WKWebView*)webView didFinishNavigation:(id)navigation {
        %orig;

        [webView evaluateJavaScript: [GamepadSupport javascript] completionHandler: nil];
    }
%end
