//
//  MainItem.h
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainItem : NSObject

#pragma mark - Properties -

@property (nonatomic) int mainID;
@property (nonatomic, strong) NSString *mainDescription;
@property (nonatomic) int itemNo;

#pragma mark - Setter & Getter -

+ (MainItem *)getInstance;
- (void)setObject:(NSMutableArray *)items;
- (NSMutableArray *)getItems;

@end
