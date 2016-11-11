//
//  EmbeddedTableViewCell.m
//  TableInsideTable
//
//  Created by Eman on 11/11/16.
//  Copyright © 2016 Eman A. Kassem. All rights reserved.
//

#import "EmbeddedTableViewCell.h"
#import "EKApplicationConstants.h"

@implementation EmbeddedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITableView DataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    UITableViewCell *cell;
    
    cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.objectTitleDetails objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor = UIColorFromRGB(0x33CEBE);
    cell.detailTextLabel.text = [self.objectDetails objectAtIndex:indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    cell.contentView.backgroundColor = UIColorFromRGB(0xE9E9E9);
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}

#pragma mark - UITableView Delegate -

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MIN_CELL_HEIGHT;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}


@end
