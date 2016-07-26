//
//  MasterViewController.h
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"

@interface HistoryViewController : UITableViewController {
    HistoryModel * historyModel;
}

- (void) insertNewObject: (NSString *) object;


@end

