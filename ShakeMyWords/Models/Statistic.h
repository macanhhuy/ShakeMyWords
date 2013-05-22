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

@end
