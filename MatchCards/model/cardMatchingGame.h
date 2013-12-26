//
//  cardMatchingGame.h
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface cardMatchingGame : NSObject

- (id) initWithCardCount:(NSUInteger)count
     withDifficultyLevel:(int)currentDifficultyLevel
               usingDeck: (Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;


- (NSString *)flippedHistorywithScrollValue:(int)index;

@property (readonly, nonatomic) int score;
@property (readonly ,nonatomic) NSString *messageFromMatch;

@property (readonly, nonatomic) int correctMatchCount;
@property (readonly, nonatomic) int unCorrectMatchCount;


@property (readonly, nonatomic) NSMutableArray *flippedHistory;

@end
