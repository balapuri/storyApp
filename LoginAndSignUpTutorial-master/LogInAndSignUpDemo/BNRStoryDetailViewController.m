//
//  BNRStoryDetailViewController.m
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRStoryDetailViewController.h"
#import "BNRCheckUsersCellTableViewCell.h"
#import "BNRImageStore.h"

@interface BNRStoryDetailViewController ()

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BNRStoryDetailViewController


- (IBAction)dismiss:(id)sender
{
    self.storyDetail.image = self.imageView.image;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
    self.storyDetail.storyText = self.textView.text;
    
    //when the DONE button is clicked
    PFObject *story = [PFObject objectWithClassName:@"Conversation"];
    story[@"originTeller"] = [PFUser currentUser][@"username"];
    NSLog(@"originteller: %@", story[@"originTeller"]);
    story[@"title"] = @"Maya's story";
    [story saveInBackground];
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

    if (self.storyDetail.newStory) {
        self.textView.text = self.storyDetail.storyText;
        self.imageView.image = self.storyDetail.image;
    } else {
        self.textView.text = @"";
        self.imageView.image = nil;
    }
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

- (IBAction)saveText:(id)sender {
    NSString *txt = self.textView.text;
    self.storyDetail.storyText = txt;
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[BNRImageStore sharedStore] setImage:image forKey:self.storyDetail.name];
    self.imageView.image = image;
    self.storyDetail.image = image;
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
    [self uploadImage:imageData];
}

- (void)uploadImage:(NSData *)imageData {
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"user"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BNRStory *story = self.storyDetail;
    if (!story.image) {
        self.imageView.image = [[UIImage alloc] init];
    } else {
        self.imageView.image = story.image;
    }
    self.textView.text = story.storyText;
}

- (void)viewWillDisppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BNRStory *story = self.storyDetail;
    if (!self.imageView.image) {
        story.image = self.imageView.image;
    }
    
    if (!self.textView.text) {
        story.storyText = self.textView.text;
    }
}

@end
