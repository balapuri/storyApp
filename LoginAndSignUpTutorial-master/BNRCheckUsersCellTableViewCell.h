//
//  BNRCheckUsersCellTableViewCell.h
//  Storyteller
//
//  Created by Kayla Oliva on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRCheckUsersCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) NSMutableArray *checkedUsers;

@end
