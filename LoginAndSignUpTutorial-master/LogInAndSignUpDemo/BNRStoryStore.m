//
//  BNRStoryStore.m
//  LogInAndSignUpDemo
//
//  Created by Huirong Zhu on 7/9/14.
//
//

#import "BNRStoryStore.h"
#import "BNRStory.h"

@interface BNRStoryStore ()

@property (nonatomic) NSMutableArray *privateStories;

@end

@implementation BNRStoryStore

+ (instancetype)sharedStore
{
    static BNRStoryStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[BNRStoryStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRStoryStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateStories = [[NSMutableArray alloc] init];
        [self createStory];
        [self createStory];
        [self createStory];
        [self createStory];
        [self createStory];
    }
    return self;
}

- (NSArray *)allStories
{
    return [self.privateStories copy];
}

- (BNRStory *)createStory
{
    BNRStory *story = [[BNRStory alloc] init];
    
    [self.privateStories addObject:story];
    
    return story;
}

@end

