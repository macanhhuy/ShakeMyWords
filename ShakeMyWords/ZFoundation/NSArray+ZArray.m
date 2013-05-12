//
//  NSArray+ZArray.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "NSArray+ZArray.h"

@implementation NSArray (ZArray)


/**
 * @Method: Returns the first element within the array.
 *
 **/

-(id)firstObject {
    
    id object = nil;
    
    if(self.count){
        object = [self objectAtIndex:0];
    }
    
    return object;
}


/**
 * @Method: Returns a random element within an array.
 *
 **/

-(id)objectAtRandomIndex {
    
    id object = nil;
    
    if(self.count){
        object = [self objectAtIndex: arc4random() % self.count];
    }
    
    return object;
}


/**
 * @Method: Returns an array, which has been limited to a certain number of random elements.
 *
 **/

-(NSArray *)objectsRandomlyWithLimit:(int)limit{
    
    NSMutableArray * objects = [NSMutableArray array];
    
    if(self.count && limit <= self.count){
        do {
            id object = nil;
            
            do{
                
                object = [self objectAtIndex: arc4random() % self.count];

            }while ([objects containsObject:object]);

            [objects addObject:object];
            
        } while ([objects count] < limit);
    }
    
    return [objects copy];
}


/**
 * @Method: Returns an array, which has been filtered and limited to a certain number of random elements.
 *
 **/

-(NSArray *)objectsRandomlyWithLimit:(int)limit andExceptions:(NSArray *)exceptions{
    
    NSMutableArray * objects = [NSMutableArray array];
    
    if(self.count && limit <= self.count){
        do {
            id object = nil;
            
            do{
                
                object = [self objectAtIndex: arc4random() % self.count];
                
            }while ([objects containsObject:object] || [exceptions containsObject:object]);
            
            [objects addObject:object];
            
        } while ([objects count] < limit);
    }
    
    return [objects copy];
}


@end
