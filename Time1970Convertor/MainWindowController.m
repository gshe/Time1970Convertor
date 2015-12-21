//
//  MainWindowController.m
//  Time1970Convertor
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 George She. All rights reserved.
//

#import "MainWindowController.h"
#import <Foundation/NSDateFormatter.h>

@interface MainWindowController () <NSTextFieldDelegate>
@property(weak) IBOutlet NSTextField *timeInputTextField;
@property(weak) IBOutlet NSTextField *convertedTimeUTCTextField;
@property(weak) IBOutlet NSTextField *convertedTimeLocalTextField;
@property(weak) IBOutlet NSTextField *localTimeLabel;

@property(weak) IBOutlet NSTextField *utcTimeLabel;
@end

@implementation MainWindowController
- (NSString *)windowNibName {
  return NSStringFromClass(self.class);
}

- (instancetype)initWithWindow:(NSWindow *)window {
  self = [super initWithWindow:window];

  if (self) {
    // Initialization code here.
  }
  return self;
}

- (void)windowDidLoad {
  [super windowDidLoad];
  self.timeInputTextField.delegate = self;
  self.localTimeLabel.hidden = YES;
  self.utcTimeLabel.hidden = YES;
}

- (IBAction)onConvertPressed:(id)sender {
  [self convertTime];
}

- (BOOL)control:(NSControl *)control
    textShouldBeginEditing:(NSText *)fieldEditor {
  self.convertedTimeUTCTextField.stringValue = @"";
  self.convertedTimeLocalTextField.stringValue = @"";
  self.localTimeLabel.hidden = YES;
  self.utcTimeLabel.hidden = YES;
  return YES;
}

- (BOOL)control:(NSControl *)control
    textShouldEndEditing:(NSText *)fieldEditor {
  [self convertTime];
  return YES;
}

- (void)convertTime {
  NSDateFormatter *formatterUTC = [[NSDateFormatter alloc] init];
  [formatterUTC setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  [formatterUTC setTimeZone:timeZone];
  NSDateFormatter *formatterLocal = [[NSDateFormatter alloc] init];
  [formatterLocal setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

  NSString *output = @"";
  NSString *outputLocal = nil;
  NSString *inputTime = self.timeInputTextField.stringValue;
  if ([inputTime containsString:@"-"] && ![inputTime hasPrefix:@"-"]) {
    NSDate *date = [formatterUTC dateFromString:inputTime];
    long long mileSecondsFrom1970 = [date timeIntervalSince1970] * 1000;
    output = [NSString stringWithFormat:@"%lld", mileSecondsFrom1970];
  } else {
    long long secondsFrom1970 = [inputTime longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsFrom1970];
    output = [formatterUTC stringFromDate:date];
    outputLocal = [formatterLocal stringFromDate:date];
  }

  self.convertedTimeUTCTextField.stringValue = output;
  if (outputLocal) {
    self.convertedTimeLocalTextField.stringValue = outputLocal;
    self.localTimeLabel.hidden = NO;
    self.utcTimeLabel.hidden = NO;
  } else {
    self.convertedTimeLocalTextField.stringValue = @"";
    self.localTimeLabel.hidden = YES;
    self.utcTimeLabel.hidden = YES;
  }
}
@end
