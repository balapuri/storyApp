//
//  BNRCheckUsersCellTableViewCell.m
//  Storyteller
//
//  Created by Kayla Oliva on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRCheckUsersCellTableViewCell.h"
#import "BNRNewStoryViewController.h"

@interface BNRCheckUsersCellTableViewCell ()

@property (nonatomic) BOOL checked;

@end

@implementation BNRCheckUsersCellTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//- (IBAction)checkButton:(id)sender {
//    UIButton *addUserButton = (UIButton *)sender;
//    BNRNewStoryViewController *detailViewController = [[BNRNewStoryViewController alloc] init];
//    PFUser *user = [[detailViewController allUsers] objectAtIndex:addUserButton.tag];
//    NSInteger userRow = addUserButton.tag;
//    if (! _checked) {
//        [checkButton setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
//        _checked = YES;
//        NSLog(@"Current row: %d", userRow);
//        [_checkedUsers addObject:user];
//        
//    } else {
//        [checkButton setImage:[UIImage imageNamed:@"likeBtn.png"] forState:UIControlStateNormal];
//        _checked = NO;
//        [_checkedUsers removeObjectAtIndex:userRow];
//    }
//}

@end
