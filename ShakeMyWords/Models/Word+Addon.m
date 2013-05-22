//
//  Word+Addon.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/21/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "Word+Addon.h"
#import "Statistic+Addon.h"
#import "NSString+ZString.h"

@implementation Word (Addon)


/**
 * @Method: Returns and Creates a Statistic Word.
 *
 **/

+ (Word *)wordWithText:(NSString *)text language:(Language *)lang context:(NSManagedObjectContext *)context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    
    Word *word = [[Word alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    word.text = [text capitalizeFirstCharacter];
    word.language = lang;
    word.uid = [[NSString alloc] initWithFormat:@"%@_%@", word.text, lang.textShort]; // Creating uid.
    
    NSArray *languages = [Language allWithContext:context]; // Creating Statistics for new word
    
    for (Language *language in languages) {
        if(![language.textShort isEqualToString:lang.textShort]){ // Avoid duplicates
            [Statistic newStatisticForWord:word language:language context:context];
        }
    }
    return word;
}


/**
 * @Method: Returns every words which belong to a specific language.
 *
 **/

+ (NSArray *)allWithLanguage:(Language *)language context:(NSManagedObjectContext *)context{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"text" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [fetchRequest setSortDescriptors:@[sort]];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"language.textShort == %@", language.textShort];
    fetchRequest.includesPendingChanges = NO;
    
    NSError *error =nil;
    NSArray *languages = [context executeFetchRequest:fetchRequest error:&error];
    
    return (!error) ? languages : nil;
}


/**
 * @Method: Returns all UIDs from every Word entities.
 *
 **/

+ (NSArray *)allUIDsWithContext:(NSManagedObjectContext *)context{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    fetchRequest.includesPendingChanges = NO;
    
    NSError *error =nil;
    NSArray *words = [context executeFetchRequest:fetchRequest error:&error];
    
    return (!error) ? [words valueForKey:@"uid"] : nil;
}


/**
 * @Method: Checks if a word has already been saved.
 *
 **/

+ (BOOL)isWordExist:(Word *)word context:(NSManagedObjectContext *)context{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"uid == %@", word.uid];
    fetchRequest.includesPendingChanges = NO;
    
    NSError *error = nil;
    NSArray *executedRequest = [context executeFetchRequest:fetchRequest error:&error];
    
    return (!error && executedRequest.count) ? YES : NO;
}


/**
 * @Method: Checks if severals words have already been saved.
 *
 **/

+ (BOOL)areWordsExistWithUids:(NSArray *)uids context:(NSManagedObjectContext *)context{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"uid IN %@", uids];
    fetchRequest.includesPendingChanges = NO;
    
    NSError *error = nil;
    NSArray *executedRequest = [context executeFetchRequest:fetchRequest error:&error];
    
    return (!error && executedRequest.count) ? YES : NO;
}


/**
 * @Method: Updates a Word's Statistic for a specific language, when an user fails to find a translation.
 *
 **/

- (BOOL)failledWithLanguage:(Language *)language context:(NSManagedObjectContext *)context{
    
    [[Statistic statisticWithWord:self language:language context:context] updateFailled];
    
    NSError *error =nil;
    [context save:&error];
    
    return (!error) ? YES : NO;
}


/**
 * @Method: Updates a Word's Statistic for a specific language, when an user finds a translation.
 *
 **/

- (BOOL)succeedWithLanguage:(Language *)language context:(NSManagedObjectContext *)context{
    
    [[Statistic statisticWithWord:self language:language context:context] updateSucceed];
    
    NSError *error =nil;
    [context save:&error];
    
    return (!error) ? YES : NO;
}


/**
 * @Method: Returns a Word's succes rate for a specific language.
 *
 **/

- (float)successRateWithLanguage:(Language *)language context:(NSManagedObjectContext *)context{
    return [[Statistic statisticWithWord:self language:language context:context] successRate];
}


/**
 * @Method: Returns the Word's name.
 *
 **/

-(NSString *)description{
    return self.text;
}


@end
