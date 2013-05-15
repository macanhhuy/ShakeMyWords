//
//  SettingsViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "SettingsViewController.h"
#import "MenuViewController.h"
#import "UIColor+ZColor.h"
#import "Constants.h"
#import "NSString+ZString.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *choiceLanguagesLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstLanguageButton; // disabled
@property (weak, nonatomic) IBOutlet UIButton *secondLanguageButton; // disabled
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *roundsButtons;
@property (getter = shouldUpdate, nonatomic) BOOL needUpdate;

@end


@implementation SettingsViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Defines every fonts used.
    UIFont *font = [UIFont fontWithName:FONT_LATO_REGULAR size:16];
    self.titleLabel.font = [UIFont fontWithName:FONT_LATO_BOLD size:40];
    self.choiceLanguagesLabel.font = font;
    self.firstLanguageButton.titleLabel.font = font;
    self.secondLanguageButton.titleLabel.font = font;
    
    // Changes the background of the default button that represents the default rounds' number.
    for (UIButton *button in self.roundsButtons) {
        if (button.tag == [defaults integerForKey:DEFAULT_KEY_NUMBER_ROUNDS]) {
            button.backgroundColor = [UIColor colorWithHex:COLOR_GRAY];
        }
        [button addTarget:self action:@selector(updateRoundsNumber:) forControlEvents:UIControlEventTouchDown];
    }
    [self updateUI];
}


/**
 * @Method: Updates UI, languague titles.
 *
 **/

- (void)updateUI{
    [self.firstLanguageButton setTitle:[NSLocalizedString(self.firstLanguage.textLong, nil) capitalizeFirstCharacter] forState:UIControlStateNormal];
    [self.secondLanguageButton setTitle:[NSLocalizedString(self.secondLanguage.textLong, nil) capitalizeFirstCharacter] forState:UIControlStateNormal];
}


/**
 * @Method: Changes the default rounds number.
 *
 **/

- (void)updateRoundsNumber:(UIButton *)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int oldRoundNumber = [defaults integerForKey:DEFAULT_KEY_NUMBER_ROUNDS];

    // Checks if the old rounds' number is different from the new one
    if(oldRoundNumber != sender.tag){ // Tag values have been set in the storyboard
        for (UIButton *button in self.roundsButtons) {
            
            if (button.tag == oldRoundNumber) {
                button.backgroundColor = [UIColor colorWithHex:COLOR_GRAY_LIGHT];
            }
            else if (button.tag == sender.tag){
                button.backgroundColor = [UIColor colorWithHex:COLOR_GRAY];
            }
        }
        
        [defaults setInteger:sender.tag forKey:DEFAULT_KEY_NUMBER_ROUNDS];
        [defaults synchronize];
    }
}

/**
 * @Method: Switches Languages
 *
 **/

- (IBAction)switchLanguages:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Switch languages.
    Language *tmpLanguage = self.firstLanguage;
    self.firstLanguage = self.secondLanguage;
    self.secondLanguage = tmpLanguage;
        
    [defaults setObject:self.firstLanguage.textShort forKey:DEFAULT_KEY_FIRST_LANGUAGE];
    [defaults setObject:self.secondLanguage.textShort forKey:DEFAULT_KEY_SECOND_LANGUAGE];
    
    // Saves.
    [defaults synchronize];

    [self updateUI];
    
    self.needUpdate = YES; // Settings has been modified
}


-(void)updateAndLeave{
    if ([self shouldUpdate]) { // If settings has been modifed, the app reload the words.
        
        id controller = [self.navigationController.viewControllers objectAtIndex:0];
        
        if([controller isMemberOfClass:[MenuViewController class]]){
            MenuViewController *menuController = (MenuViewController *) controller;
            [menuController setUpSettings];
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

}

/**
 * @Method: Pop to Root View Controller
 *
 **/
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self updateAndLeave];
}

- (IBAction)backToMenu:(UIButton *)sender {
    [self updateAndLeave];
}


-(BOOL)shouldUpdate{
    if(!_needUpdate) _needUpdate = NO;
    return _needUpdate;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.roundsButtons = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
