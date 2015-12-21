//
//  Time1970Convertor.h
//  Time1970Convertor
//
//  Created by admin on 15/12/18.
//  Copyright © 2015年 George She. All rights reserved.
//

#import <AppKit/AppKit.h>

@class Time1970Convertor;

static Time1970Convertor *sharedPlugin;

@interface Time1970Convertor : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end