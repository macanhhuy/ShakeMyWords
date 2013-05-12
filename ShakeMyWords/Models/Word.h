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


/**
 * @Method: Returns and Creates a Statistic Word.
 *
 **/

+ (Word *)wordWithText:(NSString *)text language:(Language *)lang context:(NSManagedObjectContext *) context;


/**
 * @Method: Returns every words which belong to a specific language.
 *
 **/

+ (NSArray *)allWithLanguage:(Language *)language context:(NSManagedObjectContext *)context;


/**
 * @Method: Returns all UIDs from every Word entities.
 *
 **/

+ (NSArray *)allUIDsWithContext:(NSManagedObjectContext *)context;


/**
 * @Method: Checks if a word has already been saved.
 *
 **/

+ (BOOL)isWordExist:(Word *)word context:(NSManagedObjectContext *)context;


/**
 * @Method: Checks if severals words have already been saved.
 *
 **/

+ (BOOL)areWordsExistWithUids:(NSArray *)uids context:(NSManagedObjectContext *)context;


/**
 * @Method: Updates a Word's Statistic for a specific language, when an user fails to find a translation.
 *
 **/

- (BOOL)failledWithLanguage:(Language *)language context:(NSManagedObjectContext *)context;


/**
 * @Method: Updates a Word's Statistic for a specific language, when an user finds a translation.
 *
 **/

- (BOOL)succeedWithLanguage:(Language *)language context:(NSManagedObjectContext *)context;


/**
 * @Method: Returns a Word's succes rate for a specific language.
 *
 **/

- (float)successRateWithLanguage:(Language *)language context:(NSManagedObjectContext *)context;

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
