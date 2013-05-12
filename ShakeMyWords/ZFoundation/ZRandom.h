//
//  ZRandom.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRandom : NSObject


/**
 * @Method: Returns a random number, which has been determined by a range.
 *
 **/

+ (int)getNumberBetween:(int)min andTo:(int)max;


/**
 * @Method: Returns an array, which have been limited to a certain number of random numbers.
 *
 **/

+ (NSArray *)getNumbersBetween:(int)min to:(int)max andLimit:(int)limit;


/**
 * @Method: Returns an array, which have been filtered and limited to a certain number of random numbers.
 *
 **/

+ (NSArray *)getNumbersBetween:(int)min to:(int)max limit:(int)limit andExcept:(NSArray *)exceptions;

/**
 * @Method: Returns an array, which has been shuffled.
 *
 **/

+ (NSArray *)shuffleArray:(NSArray *)array;

/**
 * @Method: Returns a dictionary, which has been shuffled.
 *
 **/

+ (NSDictionary *)shuffleDictionary:(NSDictionary *)dict;

@end
