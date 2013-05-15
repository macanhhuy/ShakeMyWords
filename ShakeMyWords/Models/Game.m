//
//  Game.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Game.h"
#import "Constants.h"
#import "Language.h"
#import "NSMutableArray+ZMutableArray.h"
#import "ZRandom.h"

@interface Game ()

@property(nonatomic,readwrite) int score;
@property(getter=isStarted,readwrite) BOOL started;

@end

@implementation Game


/**
 * @Method: Initialises the Game.
 *
 **/

-(id)initWithNumberOfRounds:(int)rounds andContext:(NSManagedObjectContext *)context{
    self = [super init];
    if(self){
        _rounds = rounds;
        _context = context;
        _started = NO;
    }
    return self;
}


/**
 * @Method: Setups a new deal.
 *
 **/

-(BOOL)newDeal{
    
    BOOL dealInitiated = NO;
    
    [self cleanGame];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    Language *firstLanguage = [Language languageWithShort:[defaults stringForKey:DEFAULT_KEY_FIRST_LANGUAGE] context:self.context];
    NSArray *listWordsFirstLanguage = [Word allWithLanguage:firstLanguage context:self.context];

    if(self.rounds && listWordsFirstLanguage.count >= self.rounds * GAME_MIN_WORDS_REQUIRED){ // Checks if the application has enough words for the first language.
        
        // Selects random words, which will be used as words to guess.
        [self.wordsToGuess addObjectsFromArray:[listWordsFirstLanguage objectsRandomlyWithLimit:self.rounds]];
                
        Language *secondLanguage = [Language languageWithShort:[defaults stringForKey:DEFAULT_KEY_SECOND_LANGUAGE] context:self.context];
        NSArray *listWordsSecondLanguage = [Word allWithLanguage:secondLanguage context:self.context];
        
        if(listWordsSecondLanguage.count >= self.rounds * GAME_MIN_WORDS_REQUIRED){ // Checks if the application has enough words for the second language.
            
            // Selects random words, which will represent the choices.
            [self.currentChoices addObjectsFromArray:[listWordsSecondLanguage objectsRandomlyWithLimit:self.rounds * GAME_MIN_WORDS_REQUIRED ]];
            dealInitiated = YES; // If every steps have been correctly performed.
        }        
    }
    return dealInitiated;
}


/**
 * @Method: Cleans the game.
 *
 **/

-(void)cleanGame{
    self.started = NO;
    self.score = 0;
    [self.wordsToGuess removeAllObjects];
    [self.currentChoices removeAllObjects];
}


/**
 * @Method: Starts the game.
 *
 **/

- (BOOL)start{
    return ([self newDeal] && [self setUpCurrentRound]) ? self.started = YES : NO;
}


/**
 * @Method: Inits the next round
 *
 **/
- (BOOL)nextRound{
    if(self.wordsToGuess.count){
        [self.wordsToGuess removeLastObject]; // Removes the previous round from the array wordsToGuess
        return [self setUpCurrentRound]; // Initialises the current round.
    }
    return NO;
}


/**
 * @Method: Setups the current round.
 *
 **/
-(BOOL)setUpCurrentRound{
    
    BOOL roundInitiated = NO;
    
    if(self.wordsToGuess.count){

        self.currentRound = [Round new];
        
        Word *word = (Word *)[self.wordsToGuess lastObject]; // Get the last word from the array wordsToGuess.
        self.currentRound.wordToGuess = word;
                
        // Get the word's translation.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language.textShort == %@",[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULT_KEY_SECOND_LANGUAGE]];
        NSArray *filteredArray = [[word.translations allObjects] filteredArrayUsingPredicate:predicate];
        
        Word *translation = (Word *)[filteredArray lastObject];
                
        self.currentRound.response = translation.text;
        
        // Get 2 differents choices for the current word        
        NSMutableArray *choices=[[NSMutableArray alloc] initWithArray:[self.currentChoices objectsRandomlyWithLimit:GAME_NUMBER_CHOICES-1 andExceptions:@[translation]]];
        [choices addObject:translation]; // Add the cuurent word to the array choices.
        [choices shuffle]; // Shuffle the array choices.
                
        self.currentRound.choices = choices;
        roundInitiated = YES;
    }
    return roundInitiated;
}


/**
 * @Method: Checks if the current round's response is correct
 *
 **/

- (BOOL)checkResponseWithString:(NSString *)string{
    
    BOOL valid = NO;
    
    if([string isEqualToString:self.currentRound.response]){
        self.score++;
        valid = YES;
    }
    
    return valid;
}


/**
 * @Method: Returns the success rate of the current deal.
 *
 **/

-(float)successRate{
    return (self.rounds > 0) ? (self.score*100)/self.rounds : 0.00;
}


/**
 *
 *  Getters & Setters
 *
 **/


- (NSMutableArray *)wordsToGuess{
    if(!_wordsToGuess) _wordsToGuess = [NSMutableArray array];
    return _wordsToGuess;
}

- (NSMutableArray *)currentChoices{
    if(!_currentChoices) _currentChoices = [NSMutableArray array];
    return _currentChoices;
}


@end
