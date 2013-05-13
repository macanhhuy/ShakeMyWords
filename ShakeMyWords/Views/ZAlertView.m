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
        
        id title = [self valueForKey:@"_titleLabel"]; // Get title label
        
        if([title isMemberOfClass:[UILabel class]]){
            UILabel *titleLabel = (UILabel *) title;
            titleLabel.font = [UIFont fontWithName:FONT_LATO_BOLD size:22]; // Change font and size
        }

        id message = [self valueForKey:@"_bodyTextLabel"]; // Get message label

        if([message isMemberOfClass:[UILabel class]]){
            UILabel *bodyTextLabel = (UILabel *) message;
            bodyTextLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:15]; // Change font and size
        }
    }
    return self;
}


/**
 * @Method : Customize some subviews of the AlertView.
 *
 **/

- (void)layoutSubviews {
    for (UIView *subview in self.subviews){ 
        
        if ([subview isMemberOfClass:[UIImageView class]]) {
            subview.hidden = YES; // Hide blue background
        }
        
        if([subview isKindOfClass:[UIButton class]]){
            
            UIButton *button = (UIButton *) subview; 
            [button setBackgroundWithHex:COLOR_MALLOW forState:UIControlStateNormal]; // Change Button background
            [button setBackgroundWithHex:COLOR_MALLOW_DARK forState:UIControlStateHighlighted];
            button.titleLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
        }
        
        if ([subview isMemberOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *) subview;
            label.textColor = [UIColor colorWithHex:COLOR_GRAY];
            label.shadowOffset = CGSizeMake(0.0f, 0.0f);
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
