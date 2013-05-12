//
//  NSMutableArray+ZMutableArray.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "NSMutableArray+ZMutableArray.h"

@implementation NSMutableArray (ZMutableArray)


/**
 * @Method: Adds an element to the array.
 *
 **/

- (void)addToFirstIndexObject:(id)object {
    [self insertObject:object atIndex:0];
}


/**
 * @Method: Shuffles all elements in an array.
 *
 **/

-(void)shuffle{
    
    int count = self.count;
    
    for (int i = 0; i < count; i++) {
        int randomInt1 = arc4random() % count;
        int randomInt2 = arc4random() % count;
        [self exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }
}

@end
