//
//  BNRNewStoryViewController.h
//  LogInAndSignUpDemo
//
//  Created by Kayla Oliva on 7/9/14.
//
//

#import <Foundation/Foundation.h>
#import "BNRStory.h"

@interface BNRNewStoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *chooseTitle;
@property (weak, nonatomic) IBOutlet UITableView *chooseUsersTableView;

@property (nonatomic) BOOL existingStory;
@property (nonatomic) BNRStory *storyDetail;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSMutableArray *checkedUsers;

- (void)updateUserArray;
- (NSArray *)allUsers;


@end
