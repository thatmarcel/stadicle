#import <WebKit/WebKit.h>
#import <GameController/GameController.h>
#import "GamepadSupport.h"

@interface SDWebViewScriptMessageHandler: NSObject <WKScriptMessageHandler>
    @property (retain) WKWebView *webView;
    @property (retain) GCExtendedGamepad *gamepad;

    - (instancetype) initWithWebView:(WKWebView*)webView;
@end
