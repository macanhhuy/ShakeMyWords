//
//  Round.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Round.h"

@implementation Round


/**
 *
 *  Getters & Setters
 *
 **/


- (NSArray *)choice{
    if(!_choices) _choices = [NSMutableArray array];
    return _choices;
}

@end
