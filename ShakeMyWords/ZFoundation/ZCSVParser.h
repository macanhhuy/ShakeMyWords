//
//  ZCSVParser.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZCSVParserDelegate;

@interface ZCSVParser : NSObject

@property (strong, nonatomic) id<ZCSVParserDelegate> delegate;
@property (readonly, nonatomic) int iterator;
@property (readonly,getter = isAborted,nonatomic) BOOL aborted;
@property (nonatomic) int limit;


/**
 * @Method: Designated initializer
 *
 **/
- (id)initWithString:(NSString *)string andDelegate:(id<ZCSVParserDelegate>)delegate;

/**
 * @Method: Init the parser with a csv file.
 *
 **/
- (id)initWithFileName:(NSString *)fileName andDelegate:(id<ZCSVParserDelegate>)delegate;


/**
 * @Method: Parse the csv content.
 *
 **/
- (void)parse;


/**
 * @Method: Abort Parsing.
 *
 **/
- (void)abortParsing;

@end

@protocol ZCSVParserDelegate <NSObject>

@required
- (void)parser:(ZCSVParser *)parser didParseRow:(NSArray *)elements;
- (void)parserDidFinish:(ZCSVParser *)parser;

@end