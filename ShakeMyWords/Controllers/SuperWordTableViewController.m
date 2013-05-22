//
//  SuperWordTableViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/17/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "SuperWordTableViewController.h"


@implementation SuperWordTableViewController


/**
 * @Method : Gets a NSManagedObjectContext from the AppDelegate
 *
 **/

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words countOfWords];
}

-(void)setWords:(ListWords *)words{
    _words = words;
    [self.tableView reloadData];
}


@end
