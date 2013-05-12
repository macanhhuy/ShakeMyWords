//
//  NSString+ZString.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZString)


/**
 * @Method: Capitalizes the first letter of a sentence and returns a String.
 *
 **/

-(NSString *)capitalizeFirstCharacter;


/**
 * @Method: Returns a sha1 string.
 *
 **/

- (NSString *)sha1;


/**
 * @Method: Checks if a string is blank or not
 *
 **/

- (BOOL)isBlank;


@end
