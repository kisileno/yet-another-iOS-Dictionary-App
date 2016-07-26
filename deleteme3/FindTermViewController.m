//
//  FindTermViewController.m
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "FindTermViewController.h"
#import "UIReferenceLibraryViewControllerWithCallbacks.h"
#import "HistoryViewController.h"

@implementation FindTermViewController


- (void) viewDidLoad {
    [super viewDidLoad];

    _buttonToTriggerHistroySegue.hidden = YES;

    if ([self navigationItemNeedToBeAdded]) {
        [self addNavigationItem];
    }

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
            addObserver: self selector: @selector(orientationChanged:)
                   name: UIDeviceOrientationDidChangeNotification
                 object: [UIDevice currentDevice]];

    defaults = [NSUserDefaults standardUserDefaults];

    word = [defaults objectForKey: @"input_text"];

    [_inputTextField setDelegate: self];
    [_inputTextField becomeFirstResponder];

    if (word) [_inputTextField setText: word];
    [self checkNullOrEmpty];

    self.navigationController.delegate = self;

}

- (void) historySegue {
    [_inputTextField resignFirstResponder];
    [_buttonToTriggerHistroySegue sendActionsForControlEvents: UIControlEventTouchUpInside];
}

- (BOOL) navigationItemNeedToBeAdded {

    bool res = self.navigationItem.leftBarButtonItems.count > 0
            && ([self.navigationItem.leftBarButtonItems[0].title isEqualToString: @" "]
            || [self.navigationItem.leftBarButtonItems[0].title isEqualToString: @""]);
    return res;
}

- (void) navigationController: (UINavigationController *) navigationController didShowViewController: (UIViewController *) viewController animated: (BOOL) animated {

    [_inputTextField becomeFirstResponder];
}


- (void) addNavigationItem {
    UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
    [item setTitle: @"History"];
    [item setTarget: self];
    [item setAction: @selector(historySegue)];
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


- (void) orientationChanged: (NSNotification *) note {

    UIDevice * device = note.object;
    switch (device.orientation) {
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

- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string {
    if ([string isEqualToString: @" "]) {
        return NO;
    }
    else {
        [self updateWord: string];
        return YES;
    }
}

- (void) setHistoryController: (HistoryViewController *) controller {
    historyController = controller;
}


- (IBAction)textFieldEditingDidChanged: (id) sender {
    [self updateWord: nil];
}

- (void) updateWord: (NSString *) update {
    if (update) {
        word = [[update stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    } else {
        word = [[[_inputTextField text] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    }

    [self debounce: @selector(checkNullOrEmpty) delay: 0.0];
}


- (BOOL) checkNullOrEmpty {
    BOOL notNull = word && ![word isEqualToString: @""];
    [_buttonDefine setEnabled: notNull];
    return notNull;
}


- (void) checkDefinition {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        BOOL _defAvailable = [word isEqualToString: @""] ? false : [UIReferenceLibraryViewController dictionaryHasDefinitionForTerm: word];
        dispatch_sync(dispatch_get_main_queue(), ^{
            definitionAvailable = _defAvailable;
//            NSLog(@"Available: %i, for word: '%@'", _defAvailable, word);
            [_buttonDefine setEnabled: _defAvailable];
        });
    });
}

- (IBAction)defineAction: (id) sender {
    [_inputTextField resignFirstResponder];
    [FindTermViewController showDefinitionCard: self forTerm: word doneButtonBlock: ^{
        [_inputTextField becomeFirstResponder];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if ([UIReferenceLibraryViewController dictionaryHasDefinitionForTerm: word]) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [historyController insertNewObject: word];
                });

            }
        });

    }];
}


- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    if ([self checkNullOrEmpty]) {
        [self defineAction: nil];
        return YES;
    } else {
        return NO;
    }

//    if (definitionAvailable) {
//        [self defineAction: nil];
//        return YES;
//    } else {
//        return NO;
//    }
}

- (void) flush {
    [defaults setObject: word forKey: @"input_text"];
}


+ (void) showDefinitionCard: (UIViewController *) view forTerm: (NSString *) term doneButtonBlock: (void (^ __nullable) (void)) block {

    UIReferenceLibraryViewControllerWithCallbacks * referenceLibraryViewController =
            [[UIReferenceLibraryViewControllerWithCallbacks alloc] initWithTerm: term doneButtonBlock: block];
    [view presentViewController: referenceLibraryViewController
                       animated: YES
                     completion: nil];
}


- (void) debounce: (SEL) action delay: (NSTimeInterval) delay {
    __weak typeof(self) weakSelf = self;
    [NSObject cancelPreviousPerformRequestsWithTarget: weakSelf selector: action object: nil];
    [weakSelf performSelector: action withObject: nil afterDelay: delay];
}


@end
