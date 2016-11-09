//
//  UIReferenceLibraryViewControllerWithCallbacks.m
//  Dict
//
//  Created by Oleksandr Kisilenko on 7/25/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "UIReferenceLibraryViewControllerWithCallbacks.h"

@implementation UIReferenceLibraryViewControllerWithCallbacks {
    void (^disappearBlock) (void);
}

- (instancetype) initWithTerm: (NSString *) term doneButtonBlock: (void (^ __nullable) (void)) block {
    self = [super initWithTerm: term];
    disappearBlock = block;
    return self;
}

- (void) viewDidDisappear: (BOOL) animated {
    if (disappearBlock) {
        [super viewDidDisappear:animated];
        disappearBlock();
    }
}

@end
