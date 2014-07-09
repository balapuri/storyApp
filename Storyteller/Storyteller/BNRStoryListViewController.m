//
//  BNRStoryListViewController.m
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRStoryListViewController.h"
#import "BNRStory.h"
#import "BNRStoryDetailViewController.h"

@interface BNRStoryListViewController ()

@property (nonatomic) NSMutableArray *currentStories;
@property (nonatomic) NSMutableArray *finishedStories;

@end

@implementation BNRStoryListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentStories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    BNRStory *story = self.currentStories[indexPath.row];
    cell.textLabel.text = story.name;
    return cell;
}

- (NSMutableArray *)currentStories
{
    if (!_currentStories) {
        _currentStories = [NSMutableArray array];
        BNRStory *story = [[BNRStory alloc] init];
        [_currentStories addObject:story];
    }
    return _currentStories;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewStory"]) {
        BNRStory *story = [[BNRStory alloc] init];
        [self.currentStories addObject:story];
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        BNRStoryDetailViewController *svc = (BNRStoryDetailViewController *)[nc topViewController];
        svc.storyDetail = story;
    } else if ([segue.identifier isEqualToString:@"ExistingStory"]) {
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        BNRStory *story = self.currentStories[ip.row];
        BNRStoryDetailViewController *svc = (BNRStoryDetailViewController *)segue.destinationViewController;
        svc.storyDetail = story;
        svc.existingStory = YES;
    }
}

@end
