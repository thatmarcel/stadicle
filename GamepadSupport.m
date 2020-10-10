#import "GamepadSupport.h"

@implementation GamepadSupport: NSObject
    + (NSString*) javascript {
        return @"var emulatedGamepad={id:\"Emulated iOS Controller\",index:0,connected:!0,timestamp:0,mapping:\"standard\",axes:[0,0,0,0],buttons:new Array(17).fill().map(e=>({pressed:!1,touched:!1,value:0}))}; window.addEventListener(\"message\", (event) => { if (event.data.egControllerData) { emulatedGamepad = event.data.egControllerData; }}, false); navigator.getGamepads=function(){window.webkit.messageHandlers.controller.postMessage({}); return [emulatedGamepad,null,null,null]};";
    }

    // I know this is a very bad way of creating JSON, but at least it works
    + (NSString*) controllerJSONForGamepad:(GCExtendedGamepad*)gamepad {
        NSString *result = [NSString stringWithFormat: @"{ \
                \"axes\": [ \
                    %f, \
                    %f, \
                    %f, \
                    %f \
                ], \
                \"buttons\": [ \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f }, \
                    { \"pressed\": %@, \"value\": %f } \
                    ], \
                \"connected\": true, \
                \"id\": \"Emulated iOS Controller\", \
                \"index\": 0, \
                \"mapping\": \"standard\", \
                \"timestamp\": 0 \
            }",
            gamepad.leftThumbstick.xAxis.value,
            -1.0 * gamepad.leftThumbstick.yAxis.value,
            gamepad.rightThumbstick.xAxis.value,
            -1.0 * gamepad.rightThumbstick.yAxis.value,


            [self stringFromBool: gamepad.buttonA.pressed], gamepad.buttonA.value,
            [self stringFromBool: gamepad.buttonB.pressed], gamepad.buttonB.value,
            [self stringFromBool: gamepad.buttonX.pressed], gamepad.buttonX.value,
            [self stringFromBool: gamepad.buttonY.pressed], gamepad.buttonY.value,

            [self stringFromBool: gamepad.leftShoulder.pressed],  gamepad.leftShoulder.value,
            [self stringFromBool: gamepad.rightShoulder.pressed], gamepad.rightShoulder.value,
            [self stringFromBool: gamepad.leftTrigger.pressed],   gamepad.leftTrigger.value,
            [self stringFromBool: gamepad.rightTrigger.pressed],  gamepad.rightTrigger.value,

            [self stringFromBool: gamepad.buttonOptions.pressed], gamepad.buttonOptions.value,
            [self stringFromBool: gamepad.buttonMenu.pressed],    gamepad.buttonMenu.value,

            [self stringFromBool: gamepad.leftThumbstickButton.pressed],  gamepad.leftThumbstickButton.value,
            [self stringFromBool: gamepad.rightThumbstickButton.pressed], gamepad.rightThumbstickButton.value,

            [self stringFromBool: gamepad.dpad.up.pressed],    gamepad.dpad.up.value,
            [self stringFromBool: gamepad.dpad.down.pressed],  gamepad.dpad.down.value,
            [self stringFromBool: gamepad.dpad.left.pressed],  gamepad.dpad.left.value,
            [self stringFromBool: gamepad.dpad.right.pressed], gamepad.dpad.right.value /*,

            gamepad.buttonHome.pressed, gamepad.buttonHome.value */
        ];

        result = [result stringByReplacingOccurrencesOfString: @"\\s+"
                         withString: @" "
                         options: NSRegularExpressionSearch
                         range: NSMakeRange(0, result.length)];

        return result;
    }

    + (NSString*) stringFromBool:(BOOL)b {
        return b ? @"true" : @"false";
    }
@end
