//
//  WordViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "WordViewController.h"
#import "Word+Addon.h"
#import "WordsTableViewController.h"
#import "AddWordViewController.h"
#import "Constants.h"

@interface WordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleWords;
@property (weak, nonatomic) IBOutlet UILabel *numberWordsLabel;
@property (strong, nonatomic) WordsTableViewController *embedController;

@end

@implementation WordViewController


/**
 * @Method: Init the Words view Controller
 *
 **/

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.titleWords.font= [UIFont fontWithName:FONT_LATO_BOLD size:40];
    self.numberWordsLabel.font= [UIFont fontWithName:FONT_LATO_REGULAR size:14];
    self.numberWordsLabel.text = [[NSString alloc]initWithFormat:@"%d",self.words.countOfWords];
    [self.words addObserver:self forKeyPath:@"words" options:0 context:NULL];
}

/**
 * @Method: Set the current words list to another controllerView.
 *
 **/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id controller = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:SEGUE_WORDS_EMBED]) {
        if ([controller isMemberOfClass:[WordsTableViewController class]]) {
            self.embedController = (WordsTableViewController *)[segue destinationViewController];
            [self.embedController setWords:self.words];
            [self.embedController setSecondLanguage:self.secondLanguage];
        }
    }
    else if ([segue.identifier isEqualToString:SEGUE_WORDS_ADD]){
        if ([controller isMemberOfClass:[AddWordViewController class]]) {
            AddWordViewController *addWordController = (AddWordViewController *)[segue destinationViewController];
            [addWordController setWords:self.words];
            [addWordController setFirstLanguage:self.firstLanguage];
            [addWordController setSecondLanguage:self.secondLanguage];
        }
    }
}


/**
 * @Method: Observe whether the words list has been modified
 *
 **/

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"words"]) {
        self.numberWordsLabel.text = [[NSString alloc] initWithFormat:@"%d",[self.words countOfWords]];
    }
        
    if ([[change valueForKey:NSKeyValueChangeKindKey] intValue] == NSKeyValueChangeInsertion) {
        [self.embedController.tableView reloadData];
    }
}


/**
 * @Method: Pop to Root View Controller
 *
 **/


- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self leave];
}


- (IBAction)backToMenu:(UIButton *)sender {
    [self leave];
}


-(void)leave{
    [self.words removeObserver:self forKeyPath:@"words"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
