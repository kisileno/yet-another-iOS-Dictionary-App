//
//  AppDelegate.h
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryViewController.h"
#import "FindTermViewController.h"
#import "HistoryModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    FindTermViewController * findController;
    HistoryViewController * historyController;
    HistoryModel * historyModel;
}

@property(strong, nonatomic) UIWindow * window;


@end

