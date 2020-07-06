#import "RNMyLibrary.h"
@implementation RNMyLibrary
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(testCallback:(RCTResponseSenderBlock)callback)
{
    NSArray *items = @[@"callback ", @"test ", @"array"];
    callback(@events);
}
@end
  