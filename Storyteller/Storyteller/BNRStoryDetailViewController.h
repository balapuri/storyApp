//
//  BNRStoryDetailViewController.h
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRStory.h"

@interface BNRStoryDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *chooseUsers;

@property (nonatomic) BOOL existingStory;
@property (nonatomic) BNRStory *storyDetail;

@end
