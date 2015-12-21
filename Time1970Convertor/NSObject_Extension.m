//
//  NSObject_Extension.m
//  Time1970Convertor
//
//  Created by admin on 15/12/18.
//  Copyright © 2015年 George She. All rights reserved.
//


#import "NSObject_Extension.h"
#import "Time1970Convertor.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[Time1970Convertor alloc] initWithBundle:plugin];
        });
    }
}
@end
