//
//  FindTermViewController.m
//  deleteme3
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "FindTermViewController.h"

@implementation FindTermViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonToTriggerHistroySegue.hidden = YES;
    
    if ([self navigationItemNeedToBeAdded]) {
        [self addNavigationItem];
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}

- (void) historySegue {
    [_buttonToTriggerHistroySegue sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (BOOL) navigationItemNeedToBeAdded {
    
    bool res = self.navigationItem.leftBarButtonItems.count > 0 && [self.navigationItem.leftBarButtonItems[0].title isEqualToString:@" "];
    return res;
}

- (void) addNavigationItem {
    NSLog(@"Adding item");
    UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
    [item setTitle:@"History"];
    [item setTarget:self];
    [item setAction:@selector(historySegue)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void) removeNavigationItem {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void) checkWithDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if ([self navigationItemNeedToBeAdded]) {
            [self addNavigationItem];
        }
    });
}

- (void) orientationChanged:(NSNotification *)note
{
    
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            [self checkWithDelay];
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            [self checkWithDelay];
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            if (![self navigationItemNeedToBeAdded]) {
                [self removeNavigationItem];
            }
            break;
            
        case UIDeviceOrientationLandscapeRight:
            if (![self navigationItemNeedToBeAdded]) {
                [self removeNavigationItem];
            }
            break;
        
        default:
            break;
    };
}

@end
