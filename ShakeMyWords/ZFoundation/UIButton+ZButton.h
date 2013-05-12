//
//  UIButton+ZButton.h
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZButton)


/**
 * @Method: Changes button's background color with a UICOLOR for a state.
 *
 **/

-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**
 * @Method: Changes button's background color from a hexadecimal string for a state.
 *
 **/

-(void)setBackgroundWithHex:(NSString *)hex forState:(UIControlState)state;

@end
