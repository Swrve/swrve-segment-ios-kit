#import "SEGSwrveIntegration.h"
#import "SEGSwrveIntegrationFactory.h"

@implementation SEGSwrveIntegrationFactory

static SEGSwrveIntegrationFactory *sSharedInstance;

// Swrve needs to be initialized early in order to work correctly.
+ (SEGSwrveIntegrationFactory *)instanceWithAppId:(int)appId apiKey:(NSString *)apiKey swrveConfig:(SwrveConfig *)swrveConfig launchOptions:(NSDictionary *)launchOptions
{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (!sSharedInstance) {
            [Swrve sharedInstanceWithAppID:appId
                                    apiKey:apiKey
                                    config:swrveConfig
                             launchOptions:launchOptions];
            sSharedInstance = [[self alloc] init];
        }
    });
    return sSharedInstance;
}

- (id)init
{
    self = [super init];
    return self;
}

- (SEGSwrveIntegration *)createWithSettings:(NSDictionary *)settings
                               forAnalytics:(SEGAnalytics *)analytics
{
    return [[SEGSwrveIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
    return @"Swrve";
}

@end

