
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

@implementation RNHTMLtoPDF {
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

   NSString *fileName = [RCTConvert NSString:options[@"fileName"]];
      NSString *password = [RCTConvert NSString:options[@"password"]];
      NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
      NSLog(@'%@',*cacheDir);
      NSString *pdfPathOutput = [cacheDir stringByAppendingPathComponent:[fileName stringByAppendingString:@"_protected.pdf"] ];
      NSLog(@'%@',*pdfPathOutput);
      CFURLRef pdfURLOutput =(__bridge_retained CFURLRef) [[NSURL alloc] initFileURLWithPath:(NSString *)pdfPathOutput];
      CFMutableDictionaryRef myDictionary = NULL;
      myDictionary = CFDictionaryCreateMutable(NULL, 0,
                                 &kCFTypeDictionaryKeyCallBacks,
                                 &kCFTypeDictionaryValueCallBacks); // 4
    //CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    //CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
      CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword,  (__bridge CFStringRef)password);
      CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword,  (__bridge CFStringRef)password);

    // Create the output context
    CGContextRef writeContext = CGPDFContextCreateWithURL(pdfURLOutput, NULL, myDictionary);
    NSString *pdfPathInput = [cacheDir stringByAppendingPathComponent:@"proposal.pdf"];
    [self drawPDFToContext:pdfPathInput withContext:writeContext];

    CGPDFContextClose(writeContext);
    CFRelease(pdfURLOutput);
    CGContextRelease(writeContext);
}      

- (void)drawPDFToContext:(NSString*)path withContext:(CGContextRef)context {
    CFURLRef pdfURL = (__bridge_retained CFURLRef)[[NSURL alloc] initFileURLWithPath:(NSString *)path];
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((CFURLRef) pdfURL);
    NSInteger numberOfPages = CGPDFDocumentGetNumberOfPages(pdfRef);
    for (int i=1; i<=numberOfPages; i++) {
        CGPDFPageRef page = CGPDFDocumentGetPage(pdfRef, i);
        CGRect mediaBox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
        CGContextBeginPage(context, &mediaBox);
        CGContextDrawPDFPage(context, page);
        CGContextEndPage(context);
    }
    CFRelease(pdfURL);
    CGPDFDocumentRelease(pdfRef);
}                              
@end