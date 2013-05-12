//
//  UIColor+ZColor.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZColor)


/**
 * @Method: Returns an UICOLOR without transparency.
 *
 **/

+ (UIColor *) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;


/**
 * @Method: Returns an UICOLOR with transparency from an hexadecimal string.
 *
 **/

+ (UIColor *) colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;


/**
 * @Method: Returns an UICOLOR from an hexadecimal string.
 *
 **/

+ (UIColor *) colorWithHex:(NSString *)hex;

@end
