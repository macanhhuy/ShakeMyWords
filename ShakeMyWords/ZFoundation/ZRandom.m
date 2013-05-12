//
//  ZRandom.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "ZRandom.h"
#include <stdlib.h>

@implementation ZRandom


/**
 * @Method: Returns a random number, which has been determined by a range.
 *
 **/

+ (int)getNumberBetween:(int)min andTo:(int)max{
    return (arc4random() % (max - min +1 )) + min;
}


/**
 * @Method: Returns an array, which have been limited to a certain number of random numbers.
 *
 **/
+ (NSArray *)getNumbersBetween:(int)min to:(int)max andLimit:(int)limit{
    
    NSMutableArray * numbers = [NSMutableArray new];
    
    if(limit && limit <= (max-min)+1){
        do {

            NSNumber *number = nil;
            
            do{
                number = [NSNumber numberWithInt:[self getNumberBetween:min andTo:max]];
            
            }while ([numbers containsObject:number] == YES);
            
            [numbers addObject:number];
            
        } while ([numbers count] < limit);
    }

    return [numbers copy];
}


/**
 * @Method: Returns an array, which have been filtered and limited to a certain number of random numbers.
 *
 **/

+ (NSArray *)getNumbersBetween:(int)min to:(int)max limit:(int)limit andExcept: (NSArray *)exceptions{
    
    NSMutableArray * numbers = [NSMutableArray new];
    
    if(limit && limit <= (max-min)+1){
        do {
            
            NSNumber *number = nil;
            
            do{
                number = [NSNumber numberWithInt:[self getNumberBetween:min andTo:max]];
                
            }while ([numbers containsObject:number] || [exceptions containsObject:number]);
            
            [numbers addObject:number];
            
        } while ([numbers count] < limit);
    }
    
    return [numbers copy];
}


/**
 * @Method: Returns an array, which has been shuffled.
 *
 **/

+(NSArray *)shuffleArray:(NSArray *)array{
    
    int count = [array count];
    NSMutableArray *shuffleArray = [[NSMutableArray alloc] initWithArray:array];
    
    for (int i = 0; i < count; i++) {
        int randomInt1 = arc4random() % count;
        int randomInt2 = arc4random() % count;
        [shuffleArray exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }

    return [shuffleArray copy];
}


/**
 * @Method: Returns a dictionary, which has been shuffled.
 *
 **/

+(NSDictionary *) shuffleDictionary:(NSDictionary *)dict{
    
    NSMutableDictionary *shuffledDict = [[NSMutableDictionary alloc] initWithCapacity:[dict count]];
    
    NSArray *keys = [dict allKeys];
    
    [self shuffleArray:keys];
    
    for (NSString * key in keys) {
        [shuffledDict setObject:[dict objectForKey:key] forKey:key];
    }
    
    return [shuffledDict copy];
}


@end
