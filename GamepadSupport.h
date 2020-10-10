#import <Foundation/Foundation.h>
#import "HIDEvent.h"
#import <GameController/GameController.h>

@interface GamepadSupport: NSObject
    + (NSString*) javascript;
    + (NSString*) controllerJSONForGamepad:(GCExtendedGamepad*)gamepad;
@end
