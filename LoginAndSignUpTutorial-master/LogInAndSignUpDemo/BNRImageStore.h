//
//  BNRImageStore.h
//  LogInAndSignUpDemo
//
//  Created by Huirong Zhu on 7/9/14.
//
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
