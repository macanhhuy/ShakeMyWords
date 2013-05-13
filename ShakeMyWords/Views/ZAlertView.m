//
//  ZAlertView.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/13/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "ZAlertView.h"
#import "UIColor+ZColor.h"
#import "UIButton+ZButton.h"
#import "Constants.h"

@implementation ZAlertView


/**
 * @Method : Designated initializer
 *
 **/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setValue:[NSNumber numberWithInt:1] forKeyPath:@"_titleLabel.tag"];
        
    }
    return self;
}


/**
 * @Method : Customize some subviews of the AlertView.
 *
 **/
#define BUTTON_SIZE_WIDTH 140.0

- (void)layoutSubviews {
    
    int i = 0;
    
    for (UIView *subview in self.subviews){ 
        
        if ([subview isMemberOfClass:[UIImageView class]]) {
            subview.hidden = YES; // Hide blue background
        }
        
        if([subview isKindOfClass:[UIButton class]]){
            
            UIButton *button = (UIButton *) subview; 
            [button setBackgroundWithHex:COLOR_MALLOW forState:UIControlStateNormal]; // Change Button background
            [button setBackgroundWithHex:COLOR_MALLOW_DARK forState:UIControlStateHighlighted];
            button.titleLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
            button.titleLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:20];
            
            CGRect buttonBounds = button.bounds; // Get button bounds
            button.bounds = CGRectMake(buttonBounds.origin.x, buttonBounds.origin.y, BUTTON_SIZE_WIDTH, buttonBounds.size.height);
            
        }
        
        if ([subview isMemberOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *) subview;
            label.textColor = [UIColor colorWithHex:COLOR_GRAY];
            label.shadowOffset = CGSizeMake(0.0f, 0.0f);
            label.font = (i > 0) ? [UIFont fontWithName:FONT_LATO_REGULAR size:14] : [UIFont fontWithName:FONT_LATO_BOLD size: 20];
            i++;
        }
    }
}


/**
 * @Method : Customize UIAlertView, shadow, radius border.
 *
 **/

#define INSET_POPUP 3.0f
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect popupBounds = self.bounds; // Get popup bounds
    CGFloat originX = popupBounds.origin.x + INSET_POPUP;
    CGFloat originY = popupBounds.origin.y + INSET_POPUP;
    CGFloat width = popupBounds.size.width - (INSET_POPUP * 2.0f);
    CGFloat height = popupBounds.size.height - (INSET_POPUP * 2.0f);
    CGRect bPathFrame = CGRectMake(originX, originY, width, height);
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:0].CGPath;
    
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // Set background color
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 4.0f, [UIColor colorWithHex:@"3D3D3D"].CGColor);  // Set Shadow
    CGContextDrawPath(context, kCGPathFill);
    UIGraphicsPushContext(context); 
    CGContextAddPath(context, path);
    CGContextClip(context);

}


@end
