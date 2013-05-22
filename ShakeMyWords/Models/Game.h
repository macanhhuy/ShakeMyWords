//
//  Game.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Round.h"

@interface Game : NSObject

@property(strong,nonatomic) Round *currentRound;
@property(strong,nonatomic) NSMutableArray *wordsToGuess;
@property(strong,nonatomic) NSMutableArray *currentChoices;
@property(strong,nonatomic) NSManagedObjectContext *context;
@property(nonatomic,readonly) int score;
@property(getter=isStarted,readonly) BOOL started;
@property int rounds;


/**
 * @Method: Initialises the Game.
 *
 **/

- (id)initWithNumberOfRounds:(int)rounds andContext:(NSManagedObjectContext *)context;


/**
 * @Method: Setups a new deal.
 *
 **/

- (BOOL)newDeal;


/**
 * @Method: Starts the game.
 *
 **/

- (BOOL)start;


/**
 * @Method: Inits the next round
 *
 **/

- (BOOL)nextRound;


/**
 * @Method: Checks if the current round's response is correct
 *
 **/

- (BOOL)checkResponseWithString:(NSString *)string;


/**
 * @Method: Returns the success rate of the current deal.
 *
 **/

- (float)successRate;


@end
