#import "GamepadSupport.h"

@implementation GamepadSupport: NSObject
    + (NSString*) javascript {
        return @"var emulatedGamepad={id:\"Emulated iOS Controller\",index:0,connected:!0,timestamp:0,mapping:\"standard\",axes:[0,0,0,0],buttons:new Array(17).fill().map(e=>({pressed:!1,touched:!1,value:0}))};navigator.getGamepads=function(){window.webkit.messageHandlers.controller.postMessage({}); return [emulatedGamepad,null,null,null]};";
    }

    + (GCExtendedGamepad*) gamepad {
        if ([[GCController controllers] count] < 1) {
            return nil;
        }

        return [GCController controllers][0].extendedGamepad;
    }

    + (NSString*) controllerJSON {
        GCExtendedGamepad *gamepad = [self gamepad];

        if (!gamepad) {
            return @"";
        }

        if (@available(iOS 13.0, *)) { return [NSString stringWithFormat: @" \
                axes: [ \
                    %f, \
                    %f, \
                    %f, \
                    %f \
                ], \
                buttons: [ \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f }, \
                    { pressed: %d, value: %f } \
                    ], \
                connected: true, \
                id: \"Emulated iOS Controller\", \
                index: 0, \
                mapping: \"standard\", \
                timestamp: 0 \
            ",
            gamepad.leftThumbstick.xAxis.value,
            -1.0 * gamepad.leftThumbstick.yAxis.value,
            gamepad.rightThumbstick.xAxis.value,
            -1.0 * gamepad.rightThumbstick.yAxis.value,


            gamepad.buttonA.pressed, gamepad.buttonA.value,
            gamepad.buttonB.pressed, gamepad.buttonB.value,
            gamepad.buttonX.pressed, gamepad.buttonX.value,
            gamepad.buttonY.pressed, gamepad.buttonY.value,

            gamepad.leftShoulder.pressed,  gamepad.leftShoulder.value,
            gamepad.rightShoulder.pressed, gamepad.rightShoulder.value,
            gamepad.leftTrigger.pressed,   gamepad.leftTrigger.value,
            gamepad.rightTrigger.pressed,  gamepad.rightTrigger.value,

            gamepad.buttonOptions.pressed, gamepad.buttonOptions.value,
            gamepad.buttonMenu.pressed,    gamepad.buttonMenu.value,

            gamepad.leftThumbstickButton.pressed,  gamepad.leftThumbstickButton.value,
            gamepad.rightThumbstickButton.pressed, gamepad.rightThumbstickButton.value,

            gamepad.dpad.up.pressed,    gamepad.dpad.up.value,
            gamepad.dpad.down.pressed,  gamepad.dpad.down.value,
            gamepad.dpad.left.pressed,  gamepad.dpad.left.value,
            gamepad.dpad.right.pressed, gamepad.dpad.right.value /*,

            gamepad.buttonHome.pressed, gamepad.buttonHome.value */
        ]; }

        return @"";
    }
@end
