//
//  NSString+ZString.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "NSString+ZString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZString)


/**
 * @Method: Capitalizes the first letter of a sentence and returns a String.
 *
 **/

-(NSString *)capitalizeFirstCharacter{
    
    NSString * string = nil;
    
    if (self.length) {
        NSString *character = [[[self lowercaseString] substringToIndex:1] capitalizedString];
        string = [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:character];
    }
   
    return string;
}


/**
 * @Method: Returns a sha1 string.
 *
 **/

- (NSString *)sha1{
        
    unsigned char result[CC_SHA1_DIGEST_LENGTH+1];
    
    char *c_string= (char *)[self UTF8String];
    
    CC_SHA1(c_string, strlen(c_string), result);
    
    NSString *sha1 = [NSString new];
    
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        sha1=[sha1 stringByAppendingFormat:@"%02x", result[i]];
    }
        
    return sha1;
}


/**
 * @Method: Checks if a string is blank or not
 *
 **/

- (BOOL)isBlank{
    
        return (!self.length || [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString: @""]) ? YES : NO;
}

@end
