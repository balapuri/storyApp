//
//  BNRStoryDetailViewController.m
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRStoryDetailViewController.h"
#import "BNRCheckUsersCellTableViewCell.h"

@implementation BNRStoryDetailViewController


- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
    //when the DONE button is clicked
    //PFObject *story = [PFObject objectWithClassName:@"Conversation"];
    //story[@"originTeller"] = [PFObject currentUser];
    //story[@"tellers"] = ;
    
}

/* Protocol methods */
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load the NIB file
    UINib *nib = [UINib nibWithNibName:@"BNRUsersItemCellViewController" bundle:nil];
    
    //register this NIB, which contains the cell
    [self.chooseUsersTableView registerNib:nib forCellReuseIdentifier:@"BNRUsersItemCellViewController"];
}

- (NSArray *)grabUsers {
    NSMutableArray *allUsers = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //the find was successful
            NSLog(@"Successfuly retrieved %d users.", objects.count);
            
            for (PFObject *object in objects) {
                [allUsers addObject:object];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return allUsers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self grabUsers] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRCheckUsersCellTableViewCell *cell = [_chooseUsersTableView dequeueReusableCellWithIdentifier:@"BNRCheckUsersCellTableViewCell"];
    
    BNRCheckUsersCellTableViewCell *item = [self grabUsers][indexPath.row];
    //question: what object is item? 
    
    cell.usernameLabel.text = NSStringFromClass([item class]);
    
    return cell; 
}

@end
