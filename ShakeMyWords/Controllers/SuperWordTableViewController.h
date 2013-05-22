//
//  SuperWordTableViewController.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/17/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListWords.h"
#import "Language+Addon.h"

@interface SuperWordTableViewController : UITableViewController

@property (weak,nonatomic) ListWords *words;
@property (weak,nonatomic) Language *secondLanguage;

- (NSManagedObjectContext *)managedObjectContext;

@end
