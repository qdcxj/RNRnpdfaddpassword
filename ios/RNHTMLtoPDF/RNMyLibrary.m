
#import "RNMyLibrary.h"

@implementation RNMyLibrary

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(processString:(NSString *)input callback:(RCTResponseSenderBlock)callback)
{
  callback(@[[input stringByReplacingOccurrencesOfString:@"Goodbye" withString:@"Hello"]]);
}
@end
  