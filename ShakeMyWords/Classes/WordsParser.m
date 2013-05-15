//
//  WordsParser.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "WordsParser.h"
#import "Word.h"
#import "Constants.h"

@interface WordsParser ()

@property (weak,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSMutableArray *UIDs;

@end


@implementation WordsParser


/**
 * @Method : Designated initializer
 *
 **/

-(id)initWithContext:(NSManagedObjectContext *)context{
    self = [super init];
    if (self) {
        _context = context;
        _UIDs = [[NSMutableArray alloc] initWithArray:[Word allUIDsWithContext:self.context]];
    }
    return self;
}


/**
 * @Method : Create a Word entity with its translation
 *
 **/

-(void)parser:(ZCSVParser *)parser didParseRow:(NSArray *)elements{
    
    if(elements.count > 3){
        
        NSString *language = (NSString *) elements[0];
        Language *firstLanguage = [Language languageWithLong:[language lowercaseString] context:self.context];
        
        if(firstLanguage){
            
            language = (NSString *) elements[1];
            Language *secondLanguage = [Language languageWithLong:[language lowercaseString] context:self.context];

            if(secondLanguage){
            
                Word *firstWord = [Word wordWithText:elements[2] language:firstLanguage context:self.context];
                Word *secondWord = [Word wordWithText:elements[3] language:secondLanguage context:self.context];
                
                if([self areWordsExistWithUids:@[firstWord.uid,secondWord.uid]]){ // Check If the second word has already been saved
                    [self.context deleteObject:firstWord];
                    [self.context deleteObject:secondWord];
                    return;
                }
                
                [self.UIDs addObjectsFromArray:@[firstWord.uid,secondWord.uid]];
                [firstWord addTranslationsObject:secondWord];
            }
        }
    }
}


/**
 * @Method : Saves every Words entities
 *
 **/

-(void)parserDidFinish:(ZCSVParser *)parser{
    NSError *error = nil;
    [self.context save:&error];
}


/**
 * @Method : Checks if a word entity has already been saved.
 *
 **/

-(BOOL)areWordsExistWithUids:(NSArray *)uids{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", uids];
    NSArray * filtredArray = [self.UIDs filteredArrayUsingPredicate:predicate];
    return (filtredArray.count) ? YES : NO;    
}


@end
