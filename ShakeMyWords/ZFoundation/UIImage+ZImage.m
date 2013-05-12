//
//  UIImage+ZImage.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "UIImage+ZImage.h"
#import "UIColor+ZColor.h"

@implementation UIImage (ZImage)


/**
 * @Method: Returns an UIImage with a UIColor and a size.
 *
 **/

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
   
    UIImage *image = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context,rect);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 * @Method: Returns an UIImage From an hexadicamal string and a size.
 *
 **/

+ (UIImage *)imageWithHex:(NSString *)hex andSize:(CGSize)size {
    return [UIImage imageWithColor:[UIColor colorWithHex:hex] andSize:size];
}


@end
