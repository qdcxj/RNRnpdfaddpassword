
#import "RNRnpdfaddpassword.h"
#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTView.h>
#import <React/UIView+React.h>
#import <React/RCTUtils.h>


@implementation RNRnpdfaddpassword
    RCTPromiseResolveBlock _resolveBlock;
    RCTPromiseRejectBlock _rejectBlock;




@end


RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(convert:(NSDictionary *)options) {

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
  