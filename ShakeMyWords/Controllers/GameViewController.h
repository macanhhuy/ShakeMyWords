//
//  GameViewController.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Language+Addon.h"

@interface GameViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) Language *firstLanguage;
@property (weak, nonatomic) Language *secondLanguage;

@end
