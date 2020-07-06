#import "RNMyLibrary.h"
@implementation RNMyLibrary
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(nativeLog:(id)obj) {
  NSLog(@"开始输出日志：");
  NSLog(@"%@",obj);
  NSLog(@"日志输出完毕！");
}
@end
  