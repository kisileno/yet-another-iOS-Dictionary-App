//
//  AppDelegate.m
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
    UISplitViewController * splitViewController = (UISplitViewController *) self.window.rootViewController;
    UINavigationController * navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;

    splitViewController.delegate = self;


    UINavigationController * const controller = (UINavigationController *) self.window.rootViewController;
    for (UINavigationController * navController in [controller viewControllers]) {
        for (UIViewController * viewController in [navController childViewControllers]) {
            if ([viewController isKindOfClass: [FindTermViewController class]]) {
                findController = (FindTermViewController *) viewController;
            } else if ([viewController isKindOfClass: [HistoryViewController class]]) {
                historyController = (HistoryViewController *) viewController;
            }
        }
    }

    [findController setHistoryController: historyController];

    return YES;
}

- (void) applicationWillResignActive: (UIApplication *) application {
}

- (void) applicationDidEnterBackground: (UIApplication *) application {
    [[HistoryModel sharedInstance] flush];
    [findController flush];
}

- (void) applicationWillEnterForeground: (UIApplication *) application {
}

- (void) applicationDidBecomeActive: (UIApplication *) application {
}

- (void) applicationWillTerminate: (UIApplication *) application {
    [[HistoryModel sharedInstance] flush];
    [findController flush];
}

#pragma mark - Split view

- (BOOL) splitViewController: (UISplitViewController *) splitViewController collapseSecondaryViewController: (UIViewController *) secondaryViewController ontoPrimaryViewController: (UIViewController *) primaryViewController {

    return [secondaryViewController isKindOfClass: [UINavigationController class]] && [[(UINavigationController *) secondaryViewController topViewController] isKindOfClass: [HistoryViewController class]];
}

@end
