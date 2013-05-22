//
//  WordViewCell.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *translationLabel;

@end
