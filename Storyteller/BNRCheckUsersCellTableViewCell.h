//
//  BNRCheckUsersCellTableViewCell.h
//  Storyteller
//
//  Created by Kayla Oliva on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRCheckUsersCellTableViewCell : UITableViewCell
- (IBAction)checkButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end
