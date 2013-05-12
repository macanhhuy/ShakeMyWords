//
//  AddWordViewController.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"
#import "ListWords.h"
#import "Language.h"

@interface AddWordViewController : UIViewController <UITextFieldDelegate>

@property (weak,nonatomic) ListWords *words;
@property (weak,nonatomic) Language *firstLanguage;
@property (weak,nonatomic) Language *secondLanguage;

@end
