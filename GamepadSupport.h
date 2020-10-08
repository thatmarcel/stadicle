@import GameController;

@interface GamepadSupport: NSObject
    + (NSString*) javascript;
    + (NSString*) controllerJSON;

    + (GCExtendedGamepad*) gamepad;
@end
