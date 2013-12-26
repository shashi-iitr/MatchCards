//
//  PlayingCard.h
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
