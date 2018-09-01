#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RSClipperWrapper.h"
#import "_Clipper.h"

FOUNDATION_EXPORT double RSClipperWrapperVersionNumber;
FOUNDATION_EXPORT const unsigned char RSClipperWrapperVersionString[];

