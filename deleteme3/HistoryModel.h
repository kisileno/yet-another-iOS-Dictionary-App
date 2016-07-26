//
//  HistoryModel.h
//  Dict
//
//  Created by Oleksandr Kisilenko on 7/25/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject {
    NSMutableOrderedSet<NSString*> * history;
    BOOL altered;
}

+ (instancetype)sharedInstance;


- (void) flush;
- (NSArray<NSString*> *) getHistory;
- (void) deleteFromHistory: (NSString *) item;
- (BOOL) addToHistory: (NSString *) item;


@end
