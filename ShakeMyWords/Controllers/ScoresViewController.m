//
//  ScoresViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "ScoresViewController.h"
#import "ScoresTableViewController.h"
#import "Constants.h"

@interface ScoresViewController ()

@property(weak,nonatomic) IBOutlet UILabel *titleScoresLabel;

@end

@implementation ScoresViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleScoresLabel.font= [UIFont fontWithName:FONT_LATO_BOLD size:40];
}


/**
 * @Method: Set the current words list to the embed controllerView.
 *
 **/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: SEGUE_SCORES_EMBED]) {
        id controller = [segue destinationViewController];
        
        if([controller isMemberOfClass:[ScoresTableViewController class]]){
            ScoresTableViewController *containerController = (ScoresTableViewController *)[segue destinationViewController];
            [containerController setWords:self.words];
            [containerController setSecondLanguage:self.secondLanguage];
        }        
    }
}


/**
 * @Method: Pop to Root View Controller
 *
 **/
- (IBAction)swipeRight:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backToMenu:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
