#import <Foundation/Foundation.h>
#import <Analytics/SEGAnalytics.h>

@interface SEGSwrveIntegration : NSObject <SEGIntegration>

- (instancetype)initWithSettings:(NSDictionary *)settings;

@end
