//
//  UIColor+ZColor.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "UIColor+ZColor.h"

@implementation UIColor (ZColor)


/**
 * @Method: Returns an UICOLOR without transparency.
 *
 **/

+ (UIColor *) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


/**
 * @Method: Returns an UICOLOR with transparency from an hexadecimal string.
 *
 **/

+ (UIColor *) colorWithHex:(NSString *)hex alpha:(CGFloat)alpha{
    
    UIColor *color = nil;
    
    if(hex.length == 6){
        
        NSScanner* scanner = [NSScanner scannerWithString:hex];
        unsigned int colorCode = 0;
        
        if([scanner scanHexInt:&colorCode]){
            float red, green, blue;
            
            red = (CGFloat) (unsigned char)(colorCode >> 16)/255.0;
            green = (CGFloat) (unsigned char)(colorCode >> 8)/255.0;
            blue = (CGFloat) (unsigned char)(colorCode)/255.0;
            
            color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        }
    }
    else if (hex.length == 7 && [hex characterAtIndex:0] == '#'){
        return [self colorWithHex:[hex stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]] alpha:alpha];
    }
    
    return color;
}


/**
 * @Method: Returns an UICOLOR from an hexadecimal string.
 *
 **/

+ (UIColor *) colorWithHex:(NSString *)hex{
    return [UIColor colorWithHex:hex alpha:1.0];
}



@end
