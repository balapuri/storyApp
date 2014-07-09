//
//  BNRStoryStore.h
//  LogInAndSignUpDemo
//
//  Created by Huirong Zhu on 7/9/14.
//
//

#import <Foundation/Foundation.h>

@class BNRStory;

@interface BNRStoryStore : NSObject

@property (nonatomic, readonly) NSArray *allStories;

// Notice that this is a class method and prefixed with a + instead of a -
+ (instancetype)sharedStore;
- (BNRStory *)createStory;

@end