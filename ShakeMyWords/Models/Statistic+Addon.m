//
//  Statistic+Addon.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/21/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Statistic+Addon.h"


@implementation Statistic (Addon)


/**
 * @Method: Creates and returns a new Statistic Entity
 *
 **/

+(Statistic *)newStatisticForWord:(Word *)word language:(Language *)language context:(NSManagedObjectContext *) context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Statistic" inManagedObjectContext:context];
    
    Statistic *statistic = [[Statistic alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    statistic.word = word;
    statistic.language = language;
    
    return statistic;
}


/**
 * @Method: Returns a Statistic Entity for a Word entity.
 *
 **/

+(Statistic *)statisticWithWord:(Word *)word language:(Language *)language context:(NSManagedObjectContext *) context{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Statistic"];
    request.predicate=[NSPredicate predicateWithFormat:@"word == %@ AND language == %@", word, language];
    request.includesPendingChanges = NO; // Does not include pending change
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return (!error && results) ? (Statistic *)[results lastObject] : nil;
}


/**
 * @Method: Updates a Statistic Entity when a user fails to find a translation.
 *
 **/

- (void)updateFailled{
    [self setFailled:[[NSNumber alloc] initWithInt:[self.failled intValue]+1]];
}


/**
 * @Method: Updates a Statistic Entity when a user finds a translation.
 *
 **/

- (void)updateSucceed{
    
    [self setSucceed:[[NSNumber alloc] initWithInt:[self.succeed intValue]+1]];
}

/**
 * @Method: Returns the Statistic's success rate.
 *
 **/

- (float)successRate{
    
    int succeed = [self.succeed floatValue];
    int total = succeed + [self.failled floatValue];
    
    return (total > 0) ? (succeed*100)/(total) : 0.00;
}


@end
