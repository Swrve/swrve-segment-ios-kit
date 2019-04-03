#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>
#import <SwrveSDK/SwrveSDK.h>

@interface SEGSwrveIntegrationFactory : NSObject<SEGIntegrationFactory>

+ (instancetype)instanceWithAppId:(int)appId apiKey:(NSString *)apiKey swrveConfig:(SwrveConfig *)swrveConfig;

@end
