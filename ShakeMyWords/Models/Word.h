//
//  Word.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Language, Statistic, Word;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) Language *language;
@property (nonatomic, retain) NSSet *statistics;
@property (nonatomic, retain) NSSet *translations;


@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addStatisticsObject:(Statistic *)value;
- (void)removeStatisticsObject:(Statistic *)value;
- (void)addStatistics:(NSSet *)values;
- (void)removeStatistics:(NSSet *)values;

- (void)addTranslationsObject:(Word *)value;
- (void)removeTranslationsObject:(Word *)value;
- (void)addTranslations:(NSSet *)values;
- (void)removeTranslations:(NSSet *)values;

@end
