//
//  EKApplicationConstants.h
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKApplicationConstants : NSObject

#pragma mark - Cells' Constants -

#define STATUS @"STATUS"
#define TYPE @"TYPE"
#define ITEM @"ITEM"
#define ACTION @"ACTION"
#define ACTION_VALUE @"ACTION_VALUE"

#define MIN_DETAILS_CELL_HEIGHT 44.0f
#define MIN_CELL_HEIGHT 55.0f // Default height for regular cells
#define MIN_HEADER_HEIGHT 22.0f
#define MARGIN 12.0f

#pragma mark - Cell Type Enum -

typedef enum {
    CELL_WITH_DETAILS = 1,
    CELL_EMBED_TABLE = 2
} CELL_TYPE;

#pragma mark - Cell Action Enum -

typedef enum {
    PUSH = 1,
    ADD = 2
} CELL_ACTION;

#pragma mark - Cell Status Enum -

typedef enum {
    CLOSED = 1,
    OPENED = 2
} CELL_STATUS;

#pragma mark - UIColorFromRGB-

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@end
