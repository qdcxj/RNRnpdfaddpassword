
#import "RNRnpdfaddpassword.h"

@implementation RNRnpdfaddpassword

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(doSomething:(NSString *)aString withA:(NSString *)a)
{
  NSLog(@"%@,%@",aString,a);
}

@end
  