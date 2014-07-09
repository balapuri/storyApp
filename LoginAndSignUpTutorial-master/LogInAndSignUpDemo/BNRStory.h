//
//  BNRStory.h
//  Storyteller
//
//  Created by Huirong Zhu on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRStory : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSMutableArray *players;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSMutableArray *detail;
@property (nonatomic) double orderingValue;

@end
