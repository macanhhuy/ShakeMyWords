//
//  WordViewCell.m
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import "WordViewCell.h"
#import "UIColor+ZColor.h"
#import "Constants.h"

@implementation WordViewCell


- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    [super willTransitionToState:state];
    
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
        
        for (UIView *subview in self.subviews) {
            
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) { // Looks for the deleteButtonView.
                
                UIView *deleteButtonView = (UIView *)[subview.subviews objectAtIndex:0];
                CGRect bounds = deleteButtonView.bounds;
                
                // Specifies some settings for the view that will appear over the deleteButtonView.
                UILabel *overView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
                overView.text = NSLocalizedString(@"delete",nil);
                overView.textColor = [UIColor whiteColor];
                overView.backgroundColor = [UIColor colorWithHex:COLOR_RED];
                overView.font = [UIFont fontWithName:FONT_LATO_REGULAR size:15];
                overView.textAlignment = NSTextAlignmentCenter;
                                
                [deleteButtonView addSubview:overView]; // Adds the overView to the deleteButtonView
                
                subview.hidden = YES;
            }
        }
    }
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    
    [super didTransitionToState:state];
    
    if (state == UITableViewCellStateShowingDeleteConfirmationMask || state == UITableViewCellStateDefaultMask) {
        for (UIView *subview in self.subviews) {
            
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {

                subview.hidden = NO;
                
                [UIView beginAnimations:@"anim" context:nil];
                [UIView commitAnimations];
            }
        }
    }
}

@end
