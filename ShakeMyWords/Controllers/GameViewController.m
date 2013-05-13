//
//  GameViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Word.h"
#import "Game.h"
#import "Constants.h"
#import "UIButton+ZButton.h"
#import "UIColor+ZColor.h"
#import "ZAlertView.h"

@interface GameViewController ()

@property int success;
@property (strong,nonatomic) ZAlertView *popup;
@property (strong,nonatomic) Game *game;
@property int numberRounds;

@property (weak, nonatomic) IBOutlet UILabel *wordToGuessLabel;
@property (strong,nonatomic) IBOutletCollection(UIButton) NSArray *possibilities;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;

@end


@implementation GameViewController


/**
 * @Method : Init the Game's view.
 *
 **/

- (void)viewDidLoad {
    [super viewDidLoad];

    // Fonts used
    UIFont *font = [UIFont fontWithName:FONT_LATO_REGULAR size:34];
    self.wordToGuessLabel.font = [UIFont fontWithName:FONT_LATO_BOLD size:40];
    self.progressLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:13];    
    
    // Set up every buttons
    for (UIButton * button in self.possibilities) {
        [[button titleLabel] setFont:font];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        switch (button.tag) {
            case 1:
                [button setBackgroundColor:[UIColor colorWithHex:COLOR_BLUE_DARK] forState:UIControlStateHighlighted];
                break;
            case 2:
                [button setBackgroundColor:[UIColor colorWithHex:COLOR_RED_DARK] forState:UIControlStateHighlighted];
                break;
            default:
                [button setBackgroundColor:[UIColor colorWithHex:COLOR_GREEN_DARK] forState:UIControlStateHighlighted];
                break;
        }
    }

    // Init the wrong answer popup.
    self.popup = [[ZAlertView alloc] initWithTitle:NSLocalizedString(@"the.answer.was", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"next",nil) otherButtonTitles:nil];
    self.popup.tag = GAME_POPUP_NEXT_TAG_VALUE;

    self.numberRounds = [[NSUserDefaults standardUserDefaults] integerForKey:DEFAULT_KEY_NUMBER_ROUNDS];
    self.game = [[Game alloc] initWithNumberOfRounds:self.numberRounds andContext:[self managedObjectContext]];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToMenu:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];

    [self startGame];
}


/**
 * @Method : Starts the Game
 *
 **/

-(BOOL)startGame{
    BOOL gameStarted = NO;
    
    // Start the game
    if([self.game start]){
        [self updateUI]; // Display the current round
        gameStarted = YES;
    }
    
    return gameStarted;
}


/**
 * @Method : Next Round
 *
 **/

-(void)nextRound{
    
    if([self.game nextRound]){ // If game continues
        [self updateUI];
    }
    else{ // Show a popup who indicates the game is over.
        self.popup = nil;
        NSString *message = [[NSString alloc] initWithFormat:NSLocalizedString(@"success.rate",nil), self.game.successRate];
        ZAlertView *gameOverPopup = [[ZAlertView alloc] initWithTitle:NSLocalizedString(@"game.over", nil) message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles:nil];
        [gameOverPopup show];
    }
}


/**
 * @Method : Displays the current round
 *
 **/

-(void)updateUI{

    Round *round = [self.game currentRound];
    self.wordToGuessLabel.text = round.wordToGuess.text;
    
    int rest = self.numberRounds - self.game.wordsToGuess.count + 1;
    self.progressLabel.text = [[NSString alloc] initWithFormat:@"%d/%d",rest,self.numberRounds];
    
    int i = 0;
    for (Word *word in round.choices) { // Display every choices
        if(i < GAME_NUMBER_CHOICES){
            UIButton *button = (UIButton *) [self.possibilities objectAtIndex:i];
            [button setTitle:word.text forState:UIControlStateNormal];
            i++;
        }
    }
}


/**
 * @Method: Checks user's response.
 *
 **/

- (IBAction)checkChoice:(UIButton *)button {
    
    Round *round = [self.game currentRound];
    NSManagedObjectContext * context = [self managedObjectContext];
    
    if([self.game checkResponseWithString:button.titleLabel.text]){
        [self nextRound];
        [[round wordToGuess] succeedWithLanguage:self.secondLanguage context:context]; // Update Statistics
    }
    else{ // If wrong anwser
        self.popup.message = [round response]; // Display response.
        [[round wordToGuess] failledWithLanguage:self.secondLanguage context:context]; // Update Statistics
        [self.popup show]; // Show error popup
    }
}


/**
 * @Method: Actions when an user has clicked on a button of a popup.
 *
 **/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    (alertView.tag == GAME_POPUP_NEXT_TAG_VALUE) ? [self nextRound] : [self backToMenu:nil]; // Check if game continues or if the game is over.
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


-(BOOL)canBecomeFirstResponder {
    return YES;
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake ) { // If the device has been shaked, restart the game.
        [self startGame];
    }
}


/**
 * @Method: Pop to Root View Controller
 *
 **/

- (IBAction)backToMenu:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
