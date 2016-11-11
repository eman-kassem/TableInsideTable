//
//  EKMainViewController.h
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

#pragma mark - Outlets -

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

