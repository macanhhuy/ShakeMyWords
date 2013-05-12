//
//  ListWords.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "ListWords.h"

@implementation ListWords


/**
 *@Method: Inits ListWords with an array.
 *
 **/

-(id)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        self.words = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}


/**
 *@Method: Counts all elements in the array words.
 *
 **/

- (NSUInteger)countOfWords{
    return [self.words count];
}


/**
 *@Method: Gets an element from the array words.
 *
 **/

- (id)objectInWordsAtIndex:(NSUInteger)index{
    return [self.words objectAtIndex:index];
}


/**
 *@Method: Inserts an object Word at a specific index in the array words and sort every word of this array. 
 *         
 **/

- (void)insertObject:(Word*)object inWordsAtIndex:(NSUInteger)index{
    [self.words insertObject:object atIndex:index];
    [self.words sortUsingComparator:^NSComparisonResult(id a, id b){
        NSString *first = [(Word *)a text];
        NSString *second = [(Word *)b text];
        return [first localizedCaseInsensitiveCompare:second];
    }];
}


/**
 *@Method: Inserts an object Word in the array words.
 *
 **/

- (void)insertObject:(Word *)object{
    [self insertObject:object inWordsAtIndex:self.words.count];
}


/**
 *@Method: Removes an object Word from the array words.
 *
 **/

- (void)removeObjectFromWordsAtIndex:(NSUInteger)index{
    [self.words removeObjectAtIndex:index];
}


/**
 *@Method: Replaces an object Word from the array words.
 *
 **/

- (void)replaceObjectInWordsAtIndex:(NSUInteger)index withObject:(id)object{
    [self.words replaceObjectAtIndex:index withObject:object];
}


@end