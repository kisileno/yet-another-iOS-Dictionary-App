//
//  MasterViewController.m
//  deleteme3
//
//  Created by Oleksandr Kisilenko on 7/24/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "HistoryViewController.h"
#import "FindTermViewController.h"
#import "HistoryModel.h"

@interface HistoryViewController ()

@property NSMutableArray * objects;
@end

@implementation HistoryViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    historyModel = [HistoryModel sharedInstance];
    for (NSString * item in [historyModel getHistory]) {
        [self insertIntoTable: item toTop: YES];
    }

}

- (void) viewWillAppear: (BOOL) animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear: animated];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) insertNewObject: (NSString *) object {
    BOOL override = [historyModel addToHistory: object];
    if (override) {
        NSUInteger indexOfObjectToDelete = [[self objects] indexOfObject: object];
        [self deleteFromTable: [NSIndexPath indexPathForRow: indexOfObjectToDelete inSection: 0]];
    }
    [self insertIntoTable: object toTop: YES];
}

- (void) insertIntoTable: (NSString *) object toTop: (BOOL) toTop{
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    NSUInteger indexToInsert = 0;
    if (!toTop) {
        indexToInsert = [self objects].count;
    }
    [self.objects insertObject: object atIndex: indexToInsert];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow: indexToInsert inSection: 0];
    [self.tableView insertRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];

}

#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    return self.objects.count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath: indexPath];

    NSDate * object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL) tableView: (UITableView *) tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath {
    return YES;
}

- (void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *) indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteItemWithIndex: indexPath];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void) deleteItemWithIndex: (NSIndexPath *) indexPath {
    [historyModel deleteFromHistory:[self objects][indexPath.row]];
    [self deleteFromTable: indexPath];
}

- (void) deleteFromTable:(NSIndexPath *) indexPath {
    [self.objects removeObjectAtIndex: indexPath.row];
    [self.tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationFade];
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    NSString * word = self.objects[indexPath.row];
    [FindTermViewController showDefinitionCard: self forTerm: word doneButtonBlock: nil];
}

@end
