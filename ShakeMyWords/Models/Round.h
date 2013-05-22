//
//  Round.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word+Addon.h"

@interface Round : NSObject

@property(strong,nonatomic) Word * wordToGuess;
@property(strong,nonatomic) NSString *response;
@property(strong,nonatomic) NSArray *choices;

@end
