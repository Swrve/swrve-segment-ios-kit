# Swrve Segment Integration for iOS

## Installation

To install the Segment-Swrve integration, simply add this line to your `Podfile`:

```
pod 'Segment-Swrve'
```

## Usage

After adding the dependency, you must register the integration.  To do this, import the Swrve integration in your `AppDelegate`:

```
#import <Segment-Swrve/SEGSwrveIntegrationFactory.h>
```

And add the following lines:

```
NSString *const SEGMENT_WRITE_KEY = @"...";
SEGAnalyticsConfiguration *config = [SEGAnalyticsConfiguration configurationWithWriteKey:SEGMENT_WRITE_KEY];

// FIXME Add your own App ID and Api Key here
int appId = 0;
NSString *apiKey =@"<Enter your own Api key here>";

SwrveConfig *swrveConfig = [[SwrveConfig alloc] init];

// TODO:
// To use the EU stack, include this in your config.
// swrveConfig.selectedStack = SWRVE_STACK_EU;

[config use:[SEGSwrveIntegrationFactory instanceWithAppId:appId
                                                   apiKey:apiKey
                                              swrveConfig:swrveConfig]];

[SEGAnalytics setupWithConfiguration:config];
```

## License

© Copyright Swrve Mobile Inc or its licensors. Distributed under the [Apache 2.0 License](LICENSE).  
Google Play Services Library Copyright © 2012 The Android Open Source Project. Licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).  
Gradle Copyright © 2007-2011 the original author or authors. Licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0)
