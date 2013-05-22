//
//  Language+Addon.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/21/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Language.h"

@interface Language (Addon)

/**
 * @Method: Creates and returns a new Language entity.
 *
 **/

+ (Language *) language:(NSString *)textLong textShort:(NSString *)textShort context:(NSManagedObjectContext *)context;


/**
 * @Method: Gets every Language entities.
 *
 **/
+ (NSArray *) allWithContext:(NSManagedObjectContext *)context;


/**
 * @Method: Gets a Language entity with its short name.
 *
 **/

+ (Language *) languageWithShort:(NSString *)textShort context:(NSManagedObjectContext *)context;


/**
 * @Method: Gets a Language entity with its long name.
 *
 **/

+ (Language *) languageWithLong:(NSString *)textLong context:(NSManagedObjectContext *)context;



@end
