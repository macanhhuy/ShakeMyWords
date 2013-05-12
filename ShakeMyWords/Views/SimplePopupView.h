//
//  SimplePopupView.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimplePopupViewDelegate;

@interface SimplePopupView : UIView

@property(strong,nonatomic) UIView *backgroundView;
@property(strong,nonatomic) UILabel *title;
@property(strong,nonatomic) UILabel *message;
@property(strong,nonatomic) UIButton *button;
@property(strong,nonatomic) id<SimplePopupViewDelegate> delegate;


/**
 * @Method : Designated initializer
 *
 **/

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SimplePopupViewDelegate>)delegate;


/**
 * @Method : Shows the simple popup
 *
 **/

- (void)show;


/**
 * @Method : Hides the simple popup from the superview
 *
 **/

- (void)hide;


@end

@protocol SimplePopupViewDelegate <NSObject>

@required
- (void)simplePopupViewClickedButton:(SimplePopupView *)simplePopupView;

@end