//
//  NSMutableArray+ZMutableArray.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+ZArray.h"

@interface NSMutableArray (ZMutableArray)


/**
 * @Method: Adds an element to the array.
 *
 **/

- (void)addToFirstIndexObject:(id)object;


/**
 * @Method: Shuffles all elements in an array.
 *
 **/

- (void)shuffle;

@end
