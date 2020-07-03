
#import "RNRnpdfaddpassword.h"
#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTView.h>
#import <React/UIView+React.h>
#import <React/RCTUtils.h>


@implementation RNRnpdfaddpassword {
    RCTPromiseResolveBlock _resolveBlock;
    RCTPromiseRejectBlock _rejectBlock;
}    
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(convert:(NSDictionary *)options resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
                         resolve("ok")
                  }                               
@end
  