
#import "RNRnpdfaddpassword.h"

@implementation RNRnpdfaddpassword

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(doSomething:(NSString *)aString)
{
    // NSString *fileName = [arguments objectAtIndex:0];
    // NSString *password = [arguments objectAtIndex:1];
    NSString *fileName = "qwersda";
    NSString *password = "sdhasd";
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pdfPathOutput = [cacheDir stringByAppendingPathComponent:[fileName stringByAppendingString:@"_protected.pdf"] ];
    CFURLRef pdfURLOutput =(__bridge_retained CFURLRef) [[NSURL alloc] initFileURLWithPath:(NSString *)pdfPathOutput];
    NSLog(pdfPathOutput);
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
    NSLog(@"pdf is ok");
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
  