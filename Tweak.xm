#import <WebKit/WebKit.h>
#import "GamepadSupport.h"
#import "SDWebViewScriptMessageHandler.h"
#import "HIDEvent.h"

WKWebView *activeWebView;

%hook GCExtendedGamepad
    // Fixes Safari crashing on controller input
    - (void) setValueChangedHandler:(id)handler {
        %orig(nil);
    }
%end

%hook WKWebView
    - (instancetype) initWithFrame:(CGRect)rect configuration:(WKWebViewConfiguration*)config {
        WKWebViewConfiguration* newConfig = config;

        newConfig.allowsInlineMediaPlayback = false;
        newConfig.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;

        self = %orig(rect, newConfig);

        [NSTimer scheduledTimerWithTimeInterval: 1 repeats: true block:^(NSTimer *timer) {
            if ([self.URL.absoluteString hasPrefix: @"https://stadia.google.com"]) {
                self.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36";
            } else {
                self.customUserAgent = nil;
            }
        }];

        self.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36";

        return self;
    }

    - (void) _handleGameControllerEvent:(id)event {

    }
%end

@interface TabDocument: NSObject
    @property BOOL addedScriptMessageHandler;
@end

%hook TabDocument
    %property BOOL addedScriptMessageHandler;

    - (void) webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation {
        %orig;

        if (!self.addedScriptMessageHandler) {
            [webView.configuration.userContentController removeScriptMessageHandlerForName: @"controller"];
            [webView.configuration.userContentController addScriptMessageHandler: [[SDWebViewScriptMessageHandler alloc] initWithWebView: webView] name: @"controller"];
            self.addedScriptMessageHandler = true;
        }

        [webView evaluateJavaScript: [GamepadSupport javascript] completionHandler: nil];
    }
%end
