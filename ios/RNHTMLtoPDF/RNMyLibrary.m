
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTView.h>
#import <React/UIView+React.h>
#import <React/RCTUtils.h>
#import "RNMyLibrary.h"
@implementation RNMyLibrary{
    RCTEventDispatcher *_eventDispatcher;
    RCTPromiseResolveBlock _resolveBlock;
    RCTPromiseRejectBlock _rejectBlock;
    NSString *_html;
    NSString *_fileName;
    NSString *_filePath;
    UIColor *_bgColor;
    NSInteger *_numberOfPages;
    CGSize _PDFSize;
    UIWebView *_webView;
    float _paddingBottom;
    float _paddingTop;
    float _paddingLeft;
    float _paddingRight;
    BOOL _base64;
    BOOL autoHeight;
}
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(testCallback:(RCTResponseSenderBlock)callback)
{
    NSArray *items = @[@"callback ", @"test ", @"array"];
    callback(@events);
}
@end
  