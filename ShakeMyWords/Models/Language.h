//
//  Language.h
//  ShakeMyWords
//
//  Created by Thibault Zanini on 5/6/13.
//  Copyright (c) 2013 Thibault Zanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Language : NSManagedObject

@property (nonatomic, retain) NSString * textLong;
@property (nonatomic, retain) NSString * textShort;




@end
