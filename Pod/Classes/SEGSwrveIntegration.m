#import "SEGSwrveIntegration.h"
#import <Analytics/SEGAnalyticsUtils.h>
#import <SwrveSDK/Swrve.h>

@implementation SEGSwrveIntegration

- (instancetype)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        // Swrve needs to be initialized early in order to work correctly.
    }
    return self;
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    if (payload.userId != nil && [payload.userId length] != 0) {
        NSDictionary* userProperties = @{@"customer.id": payload.userId};
        [[Swrve sharedInstance] userUpdate:userProperties];
        SEGLog(@"[[Swrve sharedInstance] userUpdate:%@]", userProperties);
    }

    [[Swrve sharedInstance] userUpdate:payload.traits];
    SEGLog(@"[[Swrve sharedInstance] userUpdate:%@]", payload.traits);
}

- (void)track:(SEGTrackPayload *)payload
{
    [[Swrve sharedInstance] event:payload.event payload:payload.properties];
    SEGLog(@"[[Swrve sharedInstance] event:%@ payload:%@]", payload.event, payload.properties);
}

- (void)screen:(SEGScreenPayload *)payload
{
    NSString *eventName = [[NSString alloc] initWithFormat:@"screen.%@", payload.name];
    [[Swrve sharedInstance] event:eventName payload:payload.properties];
    SEGLog(@"[[Swrve sharedInstance] event:%@ payload:%@]", eventName, payload.properties);
}

// alias, reset, group not implemented

// SwrveSDK automatically uses method swizzling to capture the device token
//
// - (void)registeredForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
// {
//     if ([Swrve sharedInstance].talk != nil) {
//         [[Swrve sharedInstance].talk setDeviceToken:deviceToken];
//     }
// }

// SwrveSDK automatically uses method swizzling to capture the remote notifications
//
// - (void)receivedRemoteNotification:(NSDictionary *)userInfo
// {
//     [[Swrve sharedInstance].talk pushNotificationReceived:userInfo];
// }

- (void)flush
{
    [[Swrve sharedInstance] sendQueuedEvents];
    SEGLog(@"[[Swrve sharedInstance] sendQueuedEvents]");
}

@end
