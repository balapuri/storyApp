//
//  BNRStoryDetailViewController.h
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRStory.h"

@interface BNRStoryDetailViewController : UITableViewController

@property (nonatomic) BOOL existingStory;
@property (nonatomic) BNRStory *storyDetail;

@end
