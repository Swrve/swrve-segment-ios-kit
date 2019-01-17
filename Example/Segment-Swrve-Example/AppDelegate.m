#import "AppDelegate.h"
#import <Analytics/SEGAnalytics.h>
#import <Segment-Swrve/SEGSwrveIntegrationFactory.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // If we are running unittests, let's quit here.
    BOOL runningTests = NSClassFromString(@"XCTestCase") != nil;
    if(runningTests) {
        return YES;
    }

    SEGAnalyticsConfiguration *configuration = [SEGAnalyticsConfiguration configurationWithWriteKey:@"YOUR_WRITE_KEY"];

    // FIXME Add your own App ID and Api Key here
    int appId = 0;
    NSString *apiKey =@"<Enter your own Api key here>";

    SwrveConfig *swrveConfig = [[SwrveConfig alloc] init];

    // TODO:
    // To use the EU stack, include this in your config.
    // swrveConfig.selectedStack = SWRVE_STACK_EU;

    [configuration use:[SEGSwrveIntegrationFactory instanceWithAppId:appId
                                                              apiKey:apiKey
                                                         swrveConfig:swrveConfig]];

    // Enable this to record certain application events automatically!
    configuration.trackApplicationLifecycleEvents = YES;
    // Enable this to record screen views automatically!
    configuration.recordScreenViews = YES;

    [SEGAnalytics setupWithConfiguration:configuration];
    
    [[SEGAnalytics sharedAnalytics] identify:@"f4ca124298"
                                      traits:@{ @"name": @"Michael Bolton",
                                                @"email": @"mbolton@initech.com" }];

    [[SEGAnalytics sharedAnalytics] track:@"Signed Up"
                               properties:@{ @"plan": @"Enterprise" }];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
