#import "RNMyLibrary.h"
@implementation RNMyLibrary

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSString *)env {
    return @"dssf";
}

@end
  