
//  Created by Christopher on 9/3/15.

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTView.h>
#import <React/UIView+React.h>
#import <React/RCTUtils.h>
#import "RNHTMLtoPDF.h"

#define PDFSize CGSizeMake(612,792)

@implementation UIPrintPageRenderer (PDF)
- (NSData*) printToPDF:(NSInteger**)_numberOfPages
                   backgroundColor:(UIColor*)_bgColor
{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( pdfData, self.paperRect, nil );

    [self prepareForDrawingPages: NSMakeRange(0, self.numberOfPages)];

    CGRect bounds = UIGraphicsGetPDFContextBounds();

    for ( int i = 0 ; i < self.numberOfPages ; i++ )
    {
        UIGraphicsBeginPDFPage();


        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(currentContext, _bgColor.CGColor);
        CGContextFillRect(currentContext, self.paperRect);

        [self drawPageAtIndex: i inRect: bounds];
    }

    *_numberOfPages = self.numberOfPages;

    UIGraphicsEndPDFContext();
    return pdfData;
}
@end

@implementation RNHTMLtoPDFa {
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

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@synthesize bridge = _bridge;

- (instancetype)init
{
    if (self = [super init]) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.delegate = self;
        [self addSubview:_webView];
        autoHeight = false;
    }
    return self;
}

RCT_EXPORT_METHOD(convert:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    _resolveBlock = resolve;
    _rejectBlock = reject;
     NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                             _filePath, @"filePath", nil];
        _resolveBlock(data);
}

- (void)webViewDidFinishLoad:(UIWebView *)awebView
{
    
}

@end
