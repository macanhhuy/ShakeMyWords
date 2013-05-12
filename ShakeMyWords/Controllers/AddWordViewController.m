//
//  AddWordViewController.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "AddWordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SimplePopupView.h"
#import "Constants.h"
#import "UIColor+ZColor.h"
#import "NSString+ZString.h"

@interface AddWordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstLanguageTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondLanguageTextField;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLanguageLabel;

@end


@implementation AddWordViewController


/**
 * @Method : Inits the adding word view.
 *
 **/

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIColor *grayColor = [UIColor colorWithHex:@"CACACA"];
    
    UIFont *fontLato = [UIFont fontWithName:FONT_LATO_REGULAR size:15];
    self.addLabel.font=[UIFont fontWithName:FONT_LATO_BOLD size:40];
    
    self.firstLanguageLabel.font=fontLato;
    self.secondLanguageLabel.font=fontLato;
    
    self.firstLanguageTextField.font=fontLato;
    self.firstLanguageTextField.layer.borderWidth = 1;
    self.firstLanguageTextField.layer.borderColor = grayColor.CGColor;
    
    self.secondLanguageTextField.font=fontLato;
    self.secondLanguageTextField.layer.borderWidth = 1;
    self.secondLanguageTextField.layer.borderColor = grayColor.CGColor;
        
    self.firstLanguageLabel.text = [NSLocalizedString(self.firstLanguage.textLong, nil) capitalizeFirstCharacter];
    self.secondLanguageLabel.text = [NSLocalizedString(self.secondLanguage.textLong, nil) capitalizeFirstCharacter];
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
 *@Method: Save a new word.
 *
 **/

- (IBAction)saveWordAction:(UIButton *)sender {
    
    [[self view] endEditing:YES];
    
    if(self.firstLanguageTextField.text.length && self.secondLanguageTextField.text.length){
        
        NSManagedObjectContext *context = [self managedObjectContext];
                
        Word *firstWord = [Word wordWithText:self.firstLanguageTextField.text language:self.firstLanguage context:context];
        Word *secondWord = [Word wordWithText:self.secondLanguageTextField.text language:self.secondLanguage context:context];
        
        if ([Word areWordsExistWithUids:@[firstWord.uid,secondWord.uid] context:context]) {
            NSString *message = [[NSString alloc] initWithFormat:NSLocalizedString(@"word.has.already.been.saved",nil), firstWord.text];
            SimplePopupView *errorPopup = [[SimplePopupView alloc] initWithTitle:NSLocalizedString(@"error", nil) message:message delegate:nil];
            [errorPopup show];
            return;
        }

        [firstWord addTranslationsObject:secondWord];
        
        NSError *error = nil;
        [context save:&error]; // Save the word and its transaltion
        
        if(error){
            SimplePopupView *errorPopup = [[SimplePopupView alloc] initWithTitle:NSLocalizedString(@"error", nil) message:NSLocalizedString(@"error.raised",nil) delegate:nil];
            [errorPopup show];
            return;
        }

        [self.words insertObject:firstWord]; // Will be automatically snorting.
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        SimplePopupView *errorPopup = [[SimplePopupView alloc] initWithTitle:NSLocalizedString(@"error", nil) message:NSLocalizedString(@"fields.can.not.be.empty",nil) delegate:nil];
        [errorPopup show];
    }
}


/**
 *@Method :Cancels adding word.
 *
 **/

- (IBAction)cancelAddAction:(UIButton *)sender {
    [[self view] endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *@Method : Hide the keyboard if an user touch the screen.
 *
 **/

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(textField == self.firstLanguageTextField){
        [self.secondLanguageTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
