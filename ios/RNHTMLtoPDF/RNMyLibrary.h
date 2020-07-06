
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#import <React/RCTView.h>
#else
#import <React/RCTBridgeModule.h>
#import <React/RCTView.h>
#endif

@interface RNMyLibrary : NSObject <RCTBridgeModule>

@end
  