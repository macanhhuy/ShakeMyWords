//
//  WordViewController.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListWords.h"
#import "Language+Addon.h"

@interface WordViewController : UIViewController

@property (weak,nonatomic) Language *firstLanguage;
@property (weak,nonatomic) Language *secondLanguage;
@property (weak,nonatomic) ListWords *words;

@end
