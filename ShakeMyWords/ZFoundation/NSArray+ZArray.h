//
//  NSArray+ZArray.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ZArray)


/**
 * @Method: Returns the first element within the array.
 *
 **/

- (id)firstObject;


/**
 * @Method: Returns a random element within an array.
 *
 **/

- (id)objectAtRandomIndex;


/**
 * @Method: Returns an array, which has been limited to a certain number of random elements.
 *
 **/

- (NSArray *)objectsRandomlyWithLimit:(int)limit;


/**
 * @Method: Returns an array, which has been filtered and limited to a certain number of random elements.
 *
 **/

- (NSArray *)objectsRandomlyWithLimit:(int)limit andExceptions:(NSArray *)exceptions;

@end
