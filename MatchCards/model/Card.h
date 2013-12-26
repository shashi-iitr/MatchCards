//
//  Card.h
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnSelected) BOOL unSelected;

- (int)match:(NSArray *)otherCard;
@end
