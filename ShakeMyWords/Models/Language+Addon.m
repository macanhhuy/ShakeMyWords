//
//  Language+Addon.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/21/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Language+Addon.h"

@implementation Language (Addon)

/**
 * @Method: Creates and returns a new Language Entity.
 * 
 *
 **/

+(Language *)language:(NSString *)textLong textShort:(NSString *)textShort context:(NSManagedObjectContext *)context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Language" inManagedObjectContext:context];
    
    Language *lang = [[Language alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    lang.textLong = textLong;
    lang.textShort = textShort;
    
    return lang;
}


/**
 * @Method: Gets every Language entities.
 *
 **/

+(NSArray *)allWithContext:(NSManagedObjectContext *) context{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Language"];
    request.includesPendingChanges = NO; // Does not include pending changes.
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return (!error) ? results : nil;
}


/**
 * @Method: Gets a Language entity with its short name.
 *
 **/

+(Language *)languageWithShort:(NSString *)textShort context:(NSManagedObjectContext *) context{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Language"];
    request.predicate =[NSPredicate predicateWithFormat:@"textShort == %@", textShort];
    request.includesPendingChanges = NO; // Does not include pending changes.
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return (!error && results) ? (Language *)[results lastObject] : nil;
}


/**
 * @Method: Gets a Language entity with its long name.
 *
 **/

+ (Language *) languageWithLong:(NSString *)textLong context:(NSManagedObjectContext *)context{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Language"];
    request.predicate =[NSPredicate predicateWithFormat:@"textLong == %@", textLong];
    request.includesPendingChanges = NO;
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return (!error && results) ? (Language *)[results lastObject] : nil;
}


/**
 * @Method: Returns the Language's long name.
 *
 **/

-(NSString *)description{
    return self.textLong;
}

@end
