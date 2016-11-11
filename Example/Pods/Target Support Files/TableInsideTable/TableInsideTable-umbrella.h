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

#import "EKApplicationConstants.h"
#import "EmbeddedTableViewCell.h"
#import "MainTableViewCell.h"

FOUNDATION_EXPORT double TableInsideTableVersionNumber;
FOUNDATION_EXPORT const unsigned char TableInsideTableVersionString[];

