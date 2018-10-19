#import "SEGSwrveIntegration.h"
#import <Analytics/SEGAnalyticsUtils.h>
#import <SwrveSDK/SwrveSDK.h>

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
        [SwrveSDK userUpdate:userProperties];
        SEGLog(@"[SwrveSDK userUpdate:%@]", userProperties);
    }

    [SwrveSDK userUpdate:payload.traits];
    SEGLog(@"[SwrveSDK userUpdate:%@]", payload.traits);
}

- (NSDictionary *)flatten: (NSDictionary *) payload{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSString *key in payload.allKeys) {
        id object = [payload objectForKey:key];
        if (![object isKindOfClass:[NSDictionary class]]) {
            [dict setObject:object forKey:key];
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            [dict addEntriesFromDictionary:[self flatten:object]];
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)track:(SEGTrackPayload *)payload
{
    NSDictionary *props = [self flatten:payload.properties];
    [SwrveSDK event:payload.event payload:props];
    SEGLog(@"[SwrveSDK event:%@ payload:%@]", payload.event, payload.properties);
}

- (void)screen:(SEGScreenPayload *)payload
{
    NSString *eventName = [[NSString alloc] initWithFormat:@"screen.%@", payload.name];
    [SwrveSDK event:eventName payload:payload.properties];
    SEGLog(@"[SwrveSDK event:%@ payload:%@]", eventName, payload.properties);
}

- (void)flush
{
    [SwrveSDK sendQueuedEvents];
    SEGLog(@"[SwrveSDK sendQueuedEvents]");
}

@end
