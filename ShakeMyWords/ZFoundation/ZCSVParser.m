//
//  ZCSVParser.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "ZCSVParser.h"

@interface ZCSVParser ()

@property (readwrite,getter = isAborted,nonatomic) BOOL aborted;
@property (readwrite, nonatomic) int iterator;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSArray *rows;

@end

@implementation ZCSVParser


/**
 * @Method: Designated initializer
 *
 **/
-(id)initWithString:(NSString *)string andDelegate:(id<ZCSVParserDelegate>)delegate{
    self = [super init];
    if(self){
        self.content = string;
        self.delegate = delegate;
    }
    return self;
}


/**
 * @Method: Init the parser with a csv file.
 *
 **/
- (id)initWithFileName:(NSString *)fileName andDelegate:(id<ZCSVParserDelegate>)delegate{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"csv"];
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        
    return (!error) ? self = [self initWithString:string andDelegate:delegate] : nil;
}


/**
 * @Method: Parse the csv content.
 *
 **/
-(void)parse{
    
    self.rows = [self.content componentsSeparatedByString:@"\n"];

    for (NSString *item in self.rows) {
        
        if (self.aborted || !( (self.limit == 0 ) || (self.limit > 0 && self.limit > self.iterator) )) {
            break;
        }
        
        [self parseRow:item];
        self.iterator++; // keep the number of rows which has been parsed.
    }
    
    if([self.delegate respondsToSelector:@selector(parserDidFinish:)]){
        [self.delegate parserDidFinish:self];
    }
    
    [self reset]; // Reset 
}


/**
 * @Method: Parse a row from the csv content.
 *
 **/
-(void)parseRow:(NSString *)row{
        
    if([self.delegate respondsToSelector:@selector(parser:didParseRow:)]){
        
        NSArray *elements = [self slipItemsFromRow:row];
        
        if(elements.count){

            [self.delegate parser:self didParseRow:elements];
        }
    }
}


/**
  * @Method: Splits every different data from a row.
  *
  **/
-(NSArray *)slipItemsFromRow:(NSString *)row{
            
    NSScanner *scanner = [NSScanner scannerWithString:row];
    [scanner setCharactersToBeSkipped:nil];
    NSString *element;
    NSMutableArray *elements = [NSMutableArray array]; // Keep every data well-formed.
    NSMutableString *currentElement = [NSMutableString new];
    NSCharacterSet *characters = (id)[NSMutableCharacterSet characterSetWithCharactersInString:@",\""];
    BOOL insideQuotes = NO;
    
    while ( ![scanner isAtEnd] ) {
                
        if([scanner scanUpToCharactersFromSet:characters intoString:&element]){ // If a character has been found.
            [currentElement appendString:element]; // Save the string which has been found.
        }
        
        if([scanner scanString:@"," intoString:nil]){ // If comma has been found

            if (insideQuotes) { // If inside quotes, append comma to the current element
                [currentElement appendString:@","];
            }
            else{ // Add the current element to the array named "elements".
                [elements addObject:currentElement];
                currentElement = [NSMutableString new];
            }
        }else if([scanner scanString:@"\"" intoString:nil]){
            
            if ( insideQuotes && [scanner scanString:@"\"" intoString:NULL] ) {  // Replace double quotes with a single quote.
                [currentElement appendString:@"\""]; // Append comma to the current element.
            }
            else { // Start or end of a quoted string.
                insideQuotes = !insideQuotes;
            }
            
            if([scanner isAtEnd]){ // The current row has been finished.
                [elements addObject:currentElement];
            }
        }
        else{ // The current row has been finished.
            [elements addObject:currentElement];
        }
    }
    return [elements copy];
}


/**
 * @Method: Parse a row from the csv content.
 *
 **/
-(void)reset{
    self.iterator = 0;
    self.aborted = NO;
    self.limit = 0;
    
}


/**
 * @Method: Abort Parsing. 
 *
 **/
- (void)abortParsing{
    self.aborted = YES;
}


/**
 *
 * Getters & Setters
 *
 **/


-(BOOL)isAborted{
    if(!_aborted) _aborted = NO;
    return _aborted;
}


-(int)iterator{
    if(!_iterator) _iterator = 0;
    return _iterator;
}


-(int)limit{
    if(!_limit) _limit = 0;
    return _limit;
}


@end
