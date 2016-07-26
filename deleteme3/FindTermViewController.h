//
//  FindTermViewController.h
//  deleteme3
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryViewController;

@interface FindTermViewController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate> {
    NSString * word;
    BOOL definitionAvailable;
    NSUserDefaults * defaults;
    HistoryViewController * historyController;
}
@property (strong, nonnull) IBOutlet UIButton * buttonToTriggerHistroySegue;
@property (strong, nonnull) IBOutlet UIButton * buttonDefine;




@property (strong, nonnull) IBOutlet UITextField *inputTextField;
- (void) flush;
- (void) setHistoryController:(HistoryViewController * _Nonnull) controller;
+ (void) showDefinitionCard:(UIViewController * _Nonnull) view  forTerm: (NSString * _Nonnull) term  doneButtonBlock: (void (^ __nullable) (void)) block;

@end
