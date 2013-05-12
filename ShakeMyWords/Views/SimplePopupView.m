//
//  SimplePopupView.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "SimplePopupView.h"
#import "AppDelegate.h"
#import "UIColor+ZColor.h"
#import "Constants.h"
#import "UIButton+ZButton.h"


@implementation SimplePopupView


/**
 * @Method : Designated initializer
 *
 **/

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SimplePopupViewDelegate>)delegate{
    
    self = [super initWithFrame:CGRectMake(POPUP_POSITION_X,POPUP_POSITION_Y,POPUP_WIDTH,POPUP_HEIGHT)];
    
    if (self) {
                
        self.backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.backgroundView.backgroundColor = [UIColor colorWithHex:COLOR_GRAY alpha:0.3]; 
        
        self.center = CGPointMake(self.backgroundView.bounds.size.width/2, self.backgroundView.bounds.size.height/2);
        self.backgroundColor = [UIColor clearColor];
        
        UIColor *grayColor = [UIColor colorWithHex:COLOR_GRAY];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(POPUP_TITLE_POSITION_X, POPUP_TITLE_POSITION_Y, POPUP_TITLE_WIDTH, POPUP_TITLE_HEIGHT)];
        self.title.font = [UIFont fontWithName:FONT_LATO_BOLD size:24];
        self.title.textColor = grayColor;
        self.title.text = title;
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.adjustsFontSizeToFitWidth = YES;
        
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(POPUP_MESSAGE_POSITION_X, POPUP_MESSAGE_POSITION_Y, POPUP_MESSAGE_WIDTH, POPUP_MESSAGE_HEIGHT)];
        self.message.textColor = grayColor;
        self.message.font = [UIFont fontWithName:FONT_LATO_REGULAR size:15];
        self.message.text = message;
        self.message.textAlignment = NSTextAlignmentCenter;
        self.message.adjustsFontSizeToFitWidth = YES;
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(POPUP_BUTTON_POSITION_X, POPUP_BUTTON_POSITION_Y, POPUP_BUTTON_WIDTH, POPUP_BUTTON_HEIGHT);
        self.button.titleLabel.textColor = [UIColor whiteColor];
        [self.button setTitle:NSLocalizedString(@"Ok",nil) forState:UIControlStateNormal]; // Default text for the button
        [self.button setBackgroundWithHex:COLOR_MALLOW_DARK forState:UIControlStateHighlighted];
        self.button.backgroundColor = [UIColor colorWithHex:COLOR_MALLOW];
        self.button.titleLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:20];
        
        if(delegate){
            self.delegate = delegate;
            [self.button addTarget:self action:@selector(onClickedButton) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.title];
        [self addSubview:self.message];
        [self addSubview:self.button];
        
    }
    return self;
}


/**
 * @Method : Shows the simple popup
 *
 **/

-(void)show {
    
    self.backgroundView.alpha = 0.0;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:self.backgroundView];
    
    [UIView animateWithDuration:0.20 animations:^{self.backgroundView.alpha = 1.0;} completion:^(BOOL finished) {[appDelegate.window addSubview:self];}];
}


/**
 * @Method : Hides the simple popup from the superview
 *
 **/

-(void)hide {
    [self.backgroundView removeFromSuperview];
    [self removeFromSuperview];
}


/**
 * @Method : Set up shadow and radius border.
 *
 **/

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect activeBounds = self.bounds;
    CGFloat originX = activeBounds.origin.x + POPUP_INSET;
    CGFloat originY = activeBounds.origin.y + POPUP_INSET;
    CGFloat width = activeBounds.size.width - (POPUP_INSET * 2.0f);
    CGFloat height = activeBounds.size.height - (POPUP_INSET * 2.0f);
    CGRect bPathFrame = CGRectMake(originX, originY, width, height);
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:0].CGPath;

    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 4.0f, [UIColor colorWithHex:@"3D3D3D"].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    CGContextSaveGState(context); // Save Context state before clipping to path.
    CGContextAddPath(context, path);
    CGContextClip(context);
    
}


/**
 * @Method : Perfoms the delegate's action.
 *
 **/

- (void)onClickedButton {
    if(self.delegate && [self.delegate respondsToSelector:@selector(simplePopupViewClickedButton:)]){
        [self.delegate performSelector:@selector(simplePopupViewClickedButton:) withObject:self];
    }
}


@end
