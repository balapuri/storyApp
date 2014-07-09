//
//  BNRStory.m
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRStory.h"

@implementation BNRStory

- (NSString *)name
{
    if (!_name) {
        _name = [NSString stringWithFormat:@"Ronnie %d", rand()];
    }
    return _name;
}

@end
