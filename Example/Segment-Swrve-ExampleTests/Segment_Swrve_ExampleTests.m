// https://github.com/Specta/Specta

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMockito/OCMockito.h>

#import <SwrveSDK/Swrve.h>
#import <Segment-Swrve/SEGSwrveIntegration.h>

SpecBegin(InitialSpecs)

describe(@"Swrve Integration", ^{
    __block id mockSwrveClass;
    __block id mockSwrve;
    __block SEGSwrveIntegration *integration;

    beforeEach(^{
        mockSwrveClass = mockClass([Swrve class]);
        mockSwrve = mock([Swrve class]);

        stubSingleton(mockSwrveClass, sharedInstance);
        [given([Swrve sharedInstance]) willReturn:mockSwrve];

        integration = [[SEGSwrveIntegration alloc] initWithSettings:@{}];
    });

    afterEach(^{
        stopMocking(mockSwrve);
    });

    it(@"identify with no traits", ^{
        NSString *userId = @"1111";
        SEGIdentifyPayload *payload = [[SEGIdentifyPayload alloc] initWithUserId:userId anonymousId:nil traits:@{} context:@{} integrations:@{}];

        [integration identify:payload];
        [verify(mockSwrve) userUpdate:@{@"customer.id": userId}];
    });

    it(@"identify with traits", ^{
        NSString *userId = @"7891";
        NSDictionary *traits = @{
                                 @"name":@"Jerry Seinfield",
                                 @"gender":@"male",
                                 @"emotion":@"confused",
                                 @"age" :@47
                                 };

        SEGIdentifyPayload *payload = [[SEGIdentifyPayload alloc] initWithUserId:userId anonymousId:nil traits:traits context:@{} integrations:@{}];
        [integration identify:payload];

        [verify(mockSwrve) userUpdate:@{@"customer.id": userId}];
        [verify(mockSwrve) userUpdate:traits];
    });

    it(@"track with no props", ^{
        NSString *eventName = @"Email Sent";
        SEGTrackPayload *payload = [[SEGTrackPayload alloc] initWithEvent:eventName properties:@{} context:@{} integrations:@{}];

        [integration track:payload];
        [verify(mockSwrve) event:eventName payload:@{}];
    });

    it(@"track with props", ^{
        NSString *eventName = @"Starship Ordered";
        NSDictionary *properties =@{
                                    @"Starship Type": @"Death Star"
                                    };
        SEGTrackPayload *payload = [[SEGTrackPayload alloc] initWithEvent:eventName
                                                               properties:properties
                                                                  context:@{}
                                                             integrations:@{}];

        [integration track:payload];
        [verify(mockSwrve) event:eventName payload:properties];
    });
});

SpecEnd
