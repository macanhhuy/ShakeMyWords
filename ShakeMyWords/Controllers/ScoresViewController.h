//
//  ScoresViewController.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListWords.h"

@interface ScoresViewController : UIViewController

@property (weak,nonatomic) ListWords *words;
@property (weak,nonatomic) Language *secondLanguage;

@end
