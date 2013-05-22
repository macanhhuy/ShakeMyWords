//
//  ListWords.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word+Addon.h"

@interface ListWords : NSObject

@property(strong,nonatomic) NSMutableArray *words;


/**
 *@Method: Inits ListWords with an array.
 *
 **/

- (id)initWithArray:(NSArray *)array;


/**
 *@Method: Counts all elements in the array words.
 *
 **/

- (NSUInteger)countOfWords;


/**
 *@Method: Gets an element from the array words.
 *
 **/

- (id)objectInWordsAtIndex:(NSUInteger)index;


/**
 *@Method: Inserts an object Word at a specific index in the array words and sort every word of this array.
 *
 **/

- (void)insertObject:(Word *)object inWordsAtIndex:(NSUInteger)index;


/**
 *@Method: Inserts an object Word in the array words.
 *
 **/

- (void)insertObject:(Word *)object;


/**
 *@Method: Removes an object Word from the array words.
 *
 **/

- (void)removeObjectFromWordsAtIndex:(NSUInteger)index;


/**
 *@Method: Replaces an object Word from the array words.
 *
 **/

- (void)replaceObjectInWordsAtIndex:(NSUInteger)index withObject:(id)object;


@end
