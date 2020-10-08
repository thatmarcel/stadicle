#import <WebKit/WebKit.h>
#import "GamepadSupport.h"

@interface WebViewScriptMessageHandler: NSObject <WKScriptMessageHandler>
    @property (retain) WKWebView *webView;
@end
