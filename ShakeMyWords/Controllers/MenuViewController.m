//
//  MenuViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "MenuViewController.h"
#import "WordViewController.h"
#import "ScoresViewController.h"
#import "GameViewController.h"
#import "SettingsViewController.h"

#import "Word+Addon.h"
#import "Constants.h"
#import "Language+Addon.h"
#import "UIButton+ZButton.h"
#import "NSMutableArray+ZMutableArray.h"
#import "NSString+ZString.h"
#import "ZAlertView.h"


@interface MenuViewController ()

@property (strong, nonatomic) ListWords *words;
@property (strong, nonatomic) Language *firstLanguage;
@property (strong, nonatomic) Language *secondLanguage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *wordsButton;
@property (weak, nonatomic) IBOutlet UIButton *scoresButton;

@end


@implementation MenuViewController


/**
 * @Method: Sets every button, label's font.
 *
 **/

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    UIFont *fontLato = [UIFont fontWithName:FONT_LATO_REGULAR size:22];
    self.titleLabel.font = [UIFont fontWithName:FONT_LOBSTER size:42];
    
    self.scoresButton.titleLabel.font = fontLato;
    [self.scoresButton setBackgroundWithHex:COLOR_RED_DARK forState:UIControlStateHighlighted];
    self.scoresButton.titleLabel.adjustsFontSizeToFitWidth = YES;

    self.settingsButton.titleLabel.font = fontLato;
    [self.settingsButton setBackgroundWithHex:COLOR_GRAY_DARK forState:UIControlStateHighlighted];
    self.settingsButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.playButton.titleLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:36];
    [self.playButton setBackgroundWithHex:COLOR_BLUE_DARK forState:UIControlStateHighlighted];
    self.playButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.wordsButton.titleLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:32];
    [self.wordsButton setBackgroundWithHex:COLOR_GREEN_DARK forState:UIControlStateHighlighted];
    self.wordsButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self setUpSettings];
}


/**
 * @Method : Sets up some informations, such as the first, the second language and every words.
 *
 **/

-(void)setUpSettings{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    self.firstLanguage = [Language languageWithShort:[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULT_KEY_FIRST_LANGUAGE] context:context];
    self.secondLanguage = [Language languageWithShort:[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULT_KEY_SECOND_LANGUAGE] context:context];
    self.words = [[ListWords alloc] initWithArray:[[NSMutableArray alloc] initWithArray:[Word allWithLanguage:self.firstLanguage context:context]]];
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


/**
 * @Method: Set the current words list to another controllerView.
 *
 **/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: SEGUE_MENU_WORDS]) {
        id controller = [segue destinationViewController];
        
        if([controller isMemberOfClass:[WordViewController class]]){
            WordViewController *wordsController = (WordViewController *) controller;
            [wordsController setWords:self.words];
            [wordsController setFirstLanguage:self.firstLanguage];
            [wordsController setSecondLanguage:self.secondLanguage];
        }
    }
    else if ([segue.identifier isEqualToString: SEGUE_MENU_SCORES]){
        id controller = [segue destinationViewController];
        
        if([controller isMemberOfClass:[ScoresViewController class]]){
            ScoresViewController *scoresController = (ScoresViewController *) controller;
            [scoresController setWords:self.words];
            [scoresController setSecondLanguage:self.secondLanguage];
        }
    }
    else if ([segue.identifier isEqualToString: SEGUE_MENU_GAME]){
        id controller = [segue destinationViewController];
        
        if([controller isMemberOfClass:[GameViewController class]]){
            GameViewController *gameController = (GameViewController *) controller;
            [gameController setFirstLanguage:self.firstLanguage];
            [gameController setSecondLanguage:self.secondLanguage];
        }
    }
    else if ([segue.identifier isEqualToString: SEGUE_MENU_SETTINGS]){
        id controller = [segue destinationViewController];
        
        if([controller isMemberOfClass:[SettingsViewController class]]){
            SettingsViewController *gameController = (SettingsViewController *) controller;
            [gameController setFirstLanguage:self.firstLanguage];
            [gameController setSecondLanguage:self.secondLanguage];
        }
    }
}


/**
 * @Method : When swipe left
 *
 **/

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    if([self shouldPerformSegueWithIdentifier:SEGUE_MENU_GAME sender:nil])
        [self performSegueWithIdentifier:SEGUE_MENU_GAME sender:nil];
}

/**
 * @Method : Checks if the application have enough words for playing.
 *
 **/

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    BOOL response = YES;
    
    if ([identifier isEqualToString: SEGUE_MENU_GAME]) {
        // The application must have at least 3 times more words than rounds
        int minWords = [[NSUserDefaults standardUserDefaults] integerForKey:DEFAULT_KEY_NUMBER_ROUNDS] * GAME_MIN_WORDS_REQUIRED;

        if(self.words.countOfWords < minWords){
            
            NSString *message = [[NSString alloc] initWithFormat:NSLocalizedString(@"game.needs.at.least",nil),minWords];
            ZAlertView *errorPopup = [[ZAlertView alloc] initWithTitle:NSLocalizedString(@"attention",nil) message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles:nil];
            [errorPopup show];
            response = NO;
        }
    }
    return response;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
