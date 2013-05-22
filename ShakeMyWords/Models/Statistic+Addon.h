//
//  Statistic+Addon.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/21/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Statistic.h"
#import "Word+Addon.h"
#import "Language+Addon.h"

@interface Statistic (Addon)


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
