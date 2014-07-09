//
//  BNRCheckUsersCellTableViewCell.m
//  Storyteller
//
//  Created by Kayla Oliva on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRCheckUsersCellTableViewCell.h"

@interface BNRCheckUsersCellTableViewCell ()

@property (nonatomic) BOOL checked;

@end

@implementation BNRCheckUsersCellTableViewCell

@synthesize checkButton;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkButton:(id)sender {
    if (! _checked) {
        [checkButton setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        _checked = YES;
        
    } else {
        [checkButton setImage:[UIImage imageNamed:@"likeBtn.png"] forState:UIControlStateNormal];
        _checked = NO;
    }

}

@end
