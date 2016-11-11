//
//  EKMainViewController.m
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import "EKMainViewController.h"
#import "MainTableViewCell.h"
#import "EmbeddedTableViewCell.h"
#import "EKApplicationConstants.h"
#import "MainItem.h"

@interface MainViewController () {
    NSMutableArray *mainArray, *mainPlusDetailsArray;
    int variableTableIndex;
    NSMutableArray *tempArray;
    NSMutableArray *embeddedObjectTitles, *embeddedObjectDetails;
    int cellType, actionType;
    id actionValue;
    CGPoint touchPoint;
    NSIndexPath *senderIndexPath;
}

@end

@implementation EKMainViewController

#pragma mark - EKMainViewController Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Prepare titles and details for embeddedTable Data
    embeddedObjectTitles = [[NSMutableArray alloc] initWithArray:@[@"Detail #1", @"Detail #2", @"Detail #3", @"Detail #4"]];
    
    // Get courses of All Study levels at first
    mainArray = [[MainItem getInstance] getItems];
    mainPlusDetailsArray = [NSMutableArray new];
    
    for (MainItem *item in mainArray) {
        cellType = CELL_WITH_DETAILS;
        actionType = ADD;
        actionValue = [NSNumber numberWithInt:CELL_WITH_DETAILS];
        [mainPlusDetailsArray addObject:
         [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], item, [NSNumber numberWithInt:cellType], [NSNumber numberWithInt:actionType], actionValue] forKeys:@[STATUS, ITEM, TYPE, ACTION, ACTION_VALUE]]];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mainPlusDetailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *mainCellID = @"MainCell";
    MainTableViewCell *mainCell;
    
    static NSString *detailsCellID = @"DetailsCell";
    EmbeddedTableViewCell *detailsCell;
    
    switch ([[[mainPlusDetailsArray objectAtIndex:indexPath.row] objectForKey:TYPE] intValue]) {
        case CELL_WITH_DETAILS: {
            mainCell = (MainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:mainCellID];
            
            if (mainCell == nil) {
                mainCell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellID];
            }
            mainCell.mainTitle.text = [[[mainPlusDetailsArray objectAtIndex:indexPath.row] objectForKey:ITEM] mainDescription];
            // Add Action to mainButton
            mainCell.mainButton.tag = indexPath.row;
            [mainCell.mainButton addTarget:self action:@selector(getSenderIndexPath:) forControlEvents:UIControlEventTouchUpInside];
            // Toggle Button's image (Down/Up)
            [mainCell.mainButton setImage:([[[mainPlusDetailsArray objectAtIndex:indexPath.row] objectForKey:STATUS] intValue] == CLOSED) ? [UIImage imageNamed:@"down"] : [UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            [mainCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return mainCell;
        }
            break;
        case CELL_EMBED_TABLE: {
            detailsCell = (EmbeddedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:detailsCellID];
            if (detailsCell == nil) {
                detailsCell = [[EmbeddedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailsCellID];
            }
            [detailsCell setObjectTitleDetails:embeddedObjectTitles];
            [detailsCell setObjectDetails:[[mainPlusDetailsArray objectAtIndex:indexPath.row] objectForKey:ITEM]];
            [detailsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [detailsCell.detailedTable reloadData];
            
            return detailsCell;
        }
            break;
        deault:
            break;
        
    }
    return nil;
}

#pragma mark - UITableViewDelegate -

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([[[mainPlusDetailsArray objectAtIndex:indexPath.row] objectForKey:TYPE] intValue]) {
        case CELL_EMBED_TABLE:
            return MIN_DETAILS_CELL_HEIGHT * (embeddedObjectDetails.count + 1);
            break;
        case CELL_WITH_DETAILS:
            return MIN_CELL_HEIGHT;
            break;
        default:
            break;
    }
    return MIN_CELL_HEIGHT;
}

#pragma mark - Helper Methods -

- (NSMutableArray *)getDetailsFromDic:(NSDictionary *)detailsDic {
    MainItem *item = [detailsDic objectForKey:ITEM];
    NSMutableArray *tempDetails = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"%d", item.itemNo], [NSString stringWithFormat:@"%d", item.mainID], [NSString stringWithFormat:@"%d%d", item.itemNo, item.mainID], [NSString stringWithFormat:@"%d%d", item.mainID, item.itemNo]]];
    return tempDetails;
}

- (void)showHideDetailsAction:(NSIndexPath *)currentIndexPath {
    tempArray = mainPlusDetailsArray;

    int index = (int) currentIndexPath.row;
    // Add new DetailsCourseTableViewCell showing details of course at index
    if ([[[tempArray objectAtIndex:index] objectForKey:ACTION_VALUE] isKindOfClass:[NSNumber class]]) {
        cellType = [[[tempArray objectAtIndex:index] objectForKey:ACTION_VALUE] intValue];
    }
    cellType = CELL_EMBED_TABLE;
    if ([[[tempArray objectAtIndex:index] objectForKey:STATUS] intValue] == CLOSED) {
        
        NSDictionary *dic = [tempArray objectAtIndex:index];
        embeddedObjectDetails = [self getDetailsFromDic:dic];
        [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], embeddedObjectDetails, [NSNumber numberWithInt:cellType]] forKeys:@[STATUS, ITEM, TYPE]] atIndex:index + 1];
        [[tempArray objectAtIndex:index] setObject:[NSNumber numberWithInt:OPENED] forKey:STATUS];
        variableTableIndex = index + 1;
        
        [_mainTableView reloadData];
        [_mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:variableTableIndex inSection:currentIndexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    } else {
        variableTableIndex = -1;
        [[tempArray objectAtIndex:index] setObject:[NSNumber numberWithInt:CLOSED] forKey:STATUS];
        [tempArray removeObjectAtIndex:index + 1];
    }
    
    [_mainTableView reloadData];
}

- (void)getSenderIndexPath:(UIButton *)sender {
    touchPoint = [sender convertPoint:CGPointZero toView:_mainTableView];
    senderIndexPath = [_mainTableView indexPathForRowAtPoint:touchPoint];
//    NSLog(@"section:%d\nrow:%d", (int)senderIndexPath.section, (int)senderIndexPath.row);
    [self showHideDetailsAction:senderIndexPath];
}

@end
