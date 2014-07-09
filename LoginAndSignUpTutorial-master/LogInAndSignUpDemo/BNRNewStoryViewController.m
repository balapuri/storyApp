//
//  BNRNewStoryViewController.m
//  LogInAndSignUpDemo
//
//  Created by Kayla Oliva on 7/9/14.
//
//

#import "BNRNewStoryViewController.h"
#import "BNRCheckUsersCellTableViewCell.h"
#import "BNRStory.h"
#import "BNRStoryStore.h"

@implementation BNRNewStoryViewController
- (instancetype)init {
    if (self = [super init]) {
        _checkedUsers = [[NSMutableArray alloc]init];
    }
    return self;
}
- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
    //when the DONE button is clicked
    PFObject *story = [PFObject objectWithClassName:@"Conversation"];
    story[@"originTeller"] = [PFUser currentUser][@"username"];
    
    if (!self.checkedUsers) {
        NSLog(@"checkedusers is null");
    }
    if (!self.chooseTitle) {
        NSLog(@"choosetitle is null");
    }
    story[@"tellers"] = self.checkedUsers;
    story[@"storyName"] = self.chooseTitle.text;
    [story saveInBackground];
    
    BNRStory *newStory = [[BNRStoryStore sharedStore] createStory];
    newStory.name = self.chooseTitle.text;
    NSArray *m = [[BNRStoryStore sharedStore] allStories];
    for (BNRStory *s in m) {
        NSLog(@"story %@", s.name);
    }
    
}

///* Protocol methods */
- (void)viewDidLoad {
    [super viewDidLoad];
    //load the NIB file
    UINib *nib = [UINib nibWithNibName:@"BNRCheckUsersCellTableViewCell" bundle:nil];
    //register this NIB, which contains the cell
    [self.chooseUsersTableView registerNib:nib forCellReuseIdentifier:@"BNRCheckUsersCellTableViewCell"];
    
    [self updateUserArray];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    UINib *nib = [UINib nibWithNibName:@"BNRCheckUsersCellTableViewCell" bundle:nil];
    //register this NIB, which contains the cell
    [self.chooseUsersTableView registerNib:nib forCellReuseIdentifier:@"chooseUsersCell"];
    
    [self updateUserArray];
}

- (NSArray *)allUsers {
    return _users;
}

- (void)updateUserArray {
    NSMutableArray *allUsers = [[NSMutableArray alloc] init];
    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //the find was successful
            NSLog(@"Successfuly retrieved %d users.", objects.count);
            
            for (PFUser *object in objects) {
                [allUsers addObject:object];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.chooseUsersTableView reloadData];
        }];
    }];
    self.users = allUsers;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"table cell");
    BNRCheckUsersCellTableViewCell *cell = [self.chooseUsersTableView dequeueReusableCellWithIdentifier:@"BNRCheckUsersCellTableViewCell"
                                                                                           forIndexPath:indexPath];
    PFUser *user = [self users][indexPath.row];
    cell.usernameLabel.text = user[@"username"];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Uncheck the previous checked row
//    if(self.checkedIndexPath)
//    {
//        UITableViewCell* uncheckCell = [tableView
//                                        cellForRowAtIndexPath:self.checkedIndexPath];
//        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    if([self.checkedIndexPath isEqual:indexPath])
//    {
//        self.checkedIndexPath = nil;
//    }
//    else
//    {
//        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        self.checkedIndexPath = indexPath;
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //get the cell that was selected
    BNRCheckUsersCellTableViewCell *cell = (BNRCheckUsersCellTableViewCell *)[self.chooseUsersTableView cellForRowAtIndexPath:indexPath];
    PFUser *user = [self.users objectAtIndex:indexPath.row];
    
    if (!self.checkedUsers) {
        self.checkedUsers = [[NSMutableArray alloc] init];
    }
    
    if (![self.checkedUsers containsObject:user[@"username"]]) {
        // NSLog(@"user is not checked yet-------------: %@", user);
        NSLog(@"checkedusers %@", self.checkedUsers);
        [self.checkedUsers addObject:user[@"username"]];
        //        [cell.checkButton setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
    } else {
        // NSLog(@"is the user in the checked users array yet?***************");
        [self.checkedUsers removeObject:user[@"username"]];
        //        [cell.checkButton setImage:[UIImage imageNamed:@"likeBtn.png"] forState:UIControlStateDisabled];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    //get the cell that was selected
//    BNRCheckUsersCellTableViewCell *cell = (BNRCheckUsersCellTableViewCell *)[self.chooseUsersTableView cellForRowAtIndexPath:indexPath];
//    PFUser *user = [self.users objectAtIndex:indexPath.row];
//
//    if (!([self.checkedUsers containsObject:user])) {
//        NSLog(@"user is not checked yet: %@", user);
//        [self.checkedUsers addObject:user];
//        //        [cell.checkButton setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//
//
//    } else {
//        NSLog(@"have you entered else?");
//        [self.checkedUsers removeObjectAtIndex:indexPath.row];
//        //        [cell.checkButton setImage:[UIImage imageNamed:@"likeBtn.png"] forState:UIControlStateDisabled];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    NSLog(@"selected Users %@", self.checkedUsers);
//}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"I'm trying to DESELECT");
//    BNRCheckUsersCellTableViewCell *cell = (BNRCheckUsersCellTableViewCell *)[self.chooseUsersTableView cellForRowAtIndexPath:indexPath];
//    [self.checkedUsers removeObjectAtIndex:indexPath.row];
//    [cell.checkButton setImage:[UIImage imageNamed:@"likeBtn.png"] forState:UIControlStateNormal];
//}

@end
