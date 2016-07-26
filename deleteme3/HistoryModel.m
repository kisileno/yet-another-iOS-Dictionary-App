//
//  HistoryModel.m
//  Dict
//
//  Created by Oleksandr Kisilenko on 7/25/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel

- (instancetype) init {
    self = [super init];
    history = [[NSMutableOrderedSet alloc] init];
    return self;
}


+ (instancetype) sharedInstance {
    static HistoryModel * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        sharedInstance = [[HistoryModel alloc] init];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSArray<NSString *> * persistedHistory = [defaults objectForKey: @"history"];
        for (NSString * item in persistedHistory) {
            [sharedInstance addToHistory: item];
        }
    });
    return sharedInstance;
}

- (void) flush {
    if (altered) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: [history array] forKey: @"history"];
        altered = NO;
    }
}

- (NSArray<NSString *> *) getHistory {
    return [history array];
}

- (void) deleteFromHistory: (NSString *) item {
    [history removeObject: item];
    altered = YES;
}

- (BOOL) addToHistory: (NSString *) item {
    BOOL res = [history containsObject: item];
    [history removeObject: item];
    [history addObject: item];
    altered = YES;
    return res;
}


@end
