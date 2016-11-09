//
//  UIReferenceLibraryViewControllerWithCallbacks.h
//  Dict
//
//  Created by Oleksandr Kisilenko on 7/25/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIReferenceLibraryViewControllerWithCallbacks : UIReferenceLibraryViewController

- (instancetype _Nonnull) initWithTerm: (NSString * _Nonnull) term doneButtonBlock: (void (^ __nullable) (void)) block;

@end
