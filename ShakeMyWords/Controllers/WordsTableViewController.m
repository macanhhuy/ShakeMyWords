//
//  WordsViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "WordsTableViewController.h"
#import "Word.h"
#import "WordViewCell.h"
#import "Constants.h"


@implementation WordsTableViewController


/**
 * @Method : Load Data once the view did appear.
 *
 **/

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}


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
    return self.words.countOfWords;
}


/**
 * @Method: Fills a cell
 *
 **/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WordViewCell *cell = (WordViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WordCell" forIndexPath:indexPath];
    
    id object = [self.words objectInWordsAtIndex:[indexPath row]];
    
    if([object isMemberOfClass:[Word class]]){
        
        Word *word = (Word *) object;
        
        cell.textLabel.font = [UIFont fontWithName:FONT_LATO_BOLD size:22];
        cell.detailTextLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:15];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language.textShort == %@",self.secondLanguage.textShort];
        NSArray *filteredArray = [[word.translations allObjects] filteredArrayUsingPredicate:predicate];
        
        if ([filteredArray count] > 0) {
            id object =  [filteredArray lastObject];
            
            if([object isMemberOfClass:[Word class]]){
                Word * translation = (Word *) object;
                cell.textLabel.text =  word.text;
                cell.detailTextLabel.text = translation.text;
            }
        }
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


/**
 * @Method: Allows to delete a word.
 *
 **/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        Word *word = [self.words objectInWordsAtIndex:indexPath.row];

        [context deleteObject:word];
        
        NSError *error = nil;
        [context save:&error];
        
        if (!error) {
            [self.words removeObjectFromWordsAtIndex:[indexPath row]];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    } 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
