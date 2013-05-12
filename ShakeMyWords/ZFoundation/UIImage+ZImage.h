//
//  UIImage+ZImage.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZImage)


/**
 * @Method: Returns an UIImage with a UIColor and a size.
 *
 **/

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;


/**
 * @Method: Returns an UIImage From an hexadicamal string and a size.
 *
 **/

+ (UIImage *)imageWithHex:(NSString *)hex andSize:(CGSize)size;

@end
