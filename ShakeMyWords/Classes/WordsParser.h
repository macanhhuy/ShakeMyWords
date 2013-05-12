//
//  WordsParser.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSVParser.h"
#import "Language.h"


@interface WordsParser : NSObject <ZCSVParserDelegate>


/**
 * @Method : Designated initializer
 *
 **/

-(id)initWithContext:(NSManagedObjectContext *)context;


/**
 * @Method : Create a Word entity with its translation
 *
 **/

-(void)parser:(ZCSVParser *)parser didParseRow:(NSArray *)elements;


/**
 * @Method : Saves every Words entities
 *
 **/

-(void)parserDidFinish:(ZCSVParser *)parser;


@end
