#import "WebViewScriptMessageHandler.h"

@implementation WebViewScriptMessageHandler
    @synthesize webView;

    - (void) userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
        NSString *js = [NSString stringWithFormat:
                            @"try{var data=JSON.parse(\"%@\");for(let a=0;a<data.buttons.length;a++)emulatedGamepad.buttons[a].pressed=data.buttons[a].pressed,emulatedGamepad.buttons[a].value=data.buttons[a].value;for(let a=0;a<data.axes.length;a++)emulatedGamepad.axes[a]=data.axes[a]}catch(a){}",
                            [GamepadSupport controllerJSON]
        ];

        [self.webView evaluateJavaScript: js completionHandler: nil];
    }
@end
