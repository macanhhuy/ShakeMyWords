//
//  UIButton+ZButton.m
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "UIButton+ZButton.h"
#import "UIImage+ZImage.h"


@implementation UIButton (ZButton)


/**
 * @Method: Changes button's background color with a UICOLOR for a state.
 *
 **/

-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{    
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor andSize:self.bounds.size] forState:state];
}


/**
 * @Method: Changes button's background color from a hexadecimal string for a state.
 *
 **/

-(void)setBackgroundWithHex:(NSString *)hex forState:(UIControlState)state{
    [self setBackgroundImage:[UIImage imageWithHex:hex andSize:self.bounds.size] forState:state];
}



@end
