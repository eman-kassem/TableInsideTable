//
//  EmbeddedTableViewCell.h
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmbeddedTableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailedTable;
@property (strong, nonatomic) NSMutableArray *objectTitleDetails;
@property (strong, nonatomic) NSMutableArray *objectDetails;

@end
