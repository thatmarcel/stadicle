#import "SDWebViewScriptMessageHandler.h"

@implementation SDWebViewScriptMessageHandler
    @synthesize webView;
    @synthesize gamepad;

    - (void) userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
        if (!self.webView) {
            return;
        }

        if (!self.gamepad && [[GCController controllers] count] > 0) {
            self.gamepad = [GCController controllers][0].extendedGamepad;
        } else if (!self.gamepad) {
            return;
        }

        NSString *js = [NSString stringWithFormat:
                            @"try{var data=JSON.parse(\'%@\');for(let a=0;a<data.buttons.length;a++){emulatedGamepad.buttons[a].pressed=data.buttons[a].pressed,emulatedGamepad.buttons[a].value=data.buttons[a].value;}for(let a=0;a<data.axes.length;a++) {emulatedGamepad.axes[a]=data.axes[a];} window.postMessage({ egControllerData: emulatedGamepad }, \"*\");}catch(a){}",
                            [GamepadSupport controllerJSONForGamepad: self.gamepad]
        ];

        [self.webView evaluateJavaScript: js completionHandler: nil];
    }

    - (instancetype) initWithWebView:(WKWebView*)webView {
        self = [super init];
        self.webView = webView;

        if ([[GCController controllers] count] > 0) {
            self.gamepad = [GCController controllers][0].extendedGamepad;
        }

        return self;
    }
@end
