//
//  Statistic.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Language, Word;

@interface Statistic : NSManagedObject

@property (nonatomic, retain) NSNumber * failled;
@property (nonatomic, retain) NSNumber * succeed;
@property (nonatomic, retain) Language *language;
@property (nonatomic, retain) Word *word;


/**
 * @Method: Creates and returns a new Statistic Entity
 *
 **/

+(Statistic *)newStatisticForWord:(Word *)word language:(Language *)language context:(NSManagedObjectContext *)context;


/**
 * @Method: Returns a Statistic Entity for a Word entity.
 *
 **/

+(Statistic *)statisticWithWord:(Word *)word language:(Language *)language context:(NSManagedObjectContext *)context;


/**
 * @Method: Updates a Statistic Entity when a user fails to find a translation.
 *
 **/

- (void)updateFailled;


/**
 * @Method: Updates a Statistic Entity when a user finds a translation.
 *
 **/

- (void)updateSucceed;


/**
 * @Method: Returns the Statistic's success rate.
 *
 **/

- (float)successRate;


@end
