//
//  GameViewController.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Language.h"
#import "SimplePopupView.h"

@interface GameViewController : UIViewController <SimplePopupViewDelegate>

@property (weak, nonatomic) Language *firstLanguage;
@property (weak, nonatomic) Language *secondLanguage;

@end
