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
@property (weak, nonatomic) IBOutlet UIButton *buttonToTriggerHistroySegue;
@property (weak, nonatomic) IBOutlet UIButton *buttonDefine;




@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (void) flush;
- (void) setHistoryController:(HistoryViewController * ) controller;
+ (void) showDefinitionCard:(UIViewController *) view  forTerm: (NSString *) term  doneButtonBlock: (void (^ __nullable) (void)) block;

@end
