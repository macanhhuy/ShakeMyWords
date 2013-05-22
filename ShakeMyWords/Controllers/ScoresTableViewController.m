//
//  ScoresTableViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "ScoresTableViewController.h"
#import "Word+Addon.h"
#import "UIColor+ZColor.h"
#import "Constants.h"

@interface ScoresTableViewController ()

@property (strong,nonatomic) NSManagedObjectContext *context;

@end

@implementation ScoresTableViewController


/**
 * @Method : Loads Data
 *
 **/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [self managedObjectContext];
}

/**
 * @Method: Fills a cell
 *
 **/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WordCell" forIndexPath:indexPath];
    cell.textLabel.font= [UIFont fontWithName:FONT_LATO_BOLD size:22];
    cell.detailTextLabel.font= [UIFont fontWithName:FONT_LATO_REGULAR size:15];
    
    // Gets a word
    id object = [self.words objectInWordsAtIndex:indexPath.row];
    
    if([object isMemberOfClass:[Word class]]){
        
        Word *word = (Word *) object;
        cell.textLabel.text =  word.text;
        
        // Gets the word's rate.
        float rate = [word successRateWithLanguage:self.secondLanguage context:self.context];
        cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%.2f%%", rate];
        
        // Determines the detail text label color according the rate.
        if(rate < 30){
            cell.detailTextLabel.textColor = [UIColor colorWithHex:COLOR_RED];
        }
        else if(rate >= 30 && rate <= 70){
            cell.detailTextLabel.textColor = [UIColor colorWithHex:COLOR_ORANGE];
        }
        else{
            cell.detailTextLabel.textColor = [UIColor colorWithHex:COLOR_GREEN];
        }
    }
    return cell;
}

@end
