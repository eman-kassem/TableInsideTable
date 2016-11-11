//
//  MainItem.m
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import "MainItem.h"

@implementation MainItem

static MainItem *singleton = nil;

+ (MainItem *)getInstance {
    if(singleton == nil) {
        singleton = [MainItem alloc];
    }
    return singleton;
}

- (NSMutableArray *)getItems {
    NSMutableArray *result = [NSMutableArray new];
    MainItem *item;
    for (int i = 0; i < 4; i++) {
        item = [MainItem new];
        item.mainID = rand();
        item.mainDescription = [NSString stringWithFormat:@"Main Description #%d", i + 1];
        item.itemNo = rand();
        
        [result addObject:item];
    }
    
    return result;
}

- (void)setObject:(NSMutableArray *)items {
    // TODO:
}

@end
