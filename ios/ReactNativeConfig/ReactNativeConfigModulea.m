#import "ReactNativeConfig.h"
#import "ReactNativeConfigModulea.h"

@implementation ReactNativeConfigModulea

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSDictionary *)env {
    return ReactNativeConfig.env;
}

+ (NSString *)envFor: (NSString *)key {
    return [ReactNativeConfig envFor:key];
}

- (NSDictionary *)constantsToExport {
    return ReactNativeConfig.env;
}

@end
