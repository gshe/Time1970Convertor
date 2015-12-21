//
//  Time1970Convertor.m
//  Time1970Convertor
//
//  Created by admin on 15/12/18.
//  Copyright © 2015年 George She. All rights reserved.
//

#import "Time1970Convertor.h"
#import "MainWindowController.h"

@interface Time1970Convertor ()

@property(nonatomic, strong, readwrite) NSBundle *bundle;
@property(nonatomic, strong) MainWindowController *mainWindowController;
@end

@implementation Time1970Convertor

+ (instancetype)sharedPlugin {
  return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
  if (self = [super init]) {
    // reference to plugin's bundle, for resource access
    self.bundle = plugin;
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(didApplicationFinishLaunchingNotification:)
               name:NSApplicationDidFinishLaunchingNotification
             object:nil];
  }
  return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification *)noti {
  // removeObserver
  [[NSNotificationCenter defaultCenter]
      removeObserver:self
                name:NSApplicationDidFinishLaunchingNotification
              object:nil];

  // Create menu items, initialize UI, etc.
  // Sample Menu Item:
  NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
  if (menuItem) {
    [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
    NSMenuItem *actionMenuItem =
        [[NSMenuItem alloc] initWithTitle:@"Time 1970 Convertor"
                                   action:@selector(doMenuAction)
                            keyEquivalent:@""];
    //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask |
    // NSControlKeyMask];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
  }
}

// Sample Action, for menu item:
- (void)doMenuAction {
  self.mainWindowController = [[MainWindowController alloc] init];
  [self.mainWindowController showWindow:nil];
  [self.mainWindowController.window setLevel:NSMainMenuWindowLevel];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
