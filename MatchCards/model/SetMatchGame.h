//
//  SetMatchGame.h
//  MatchCards
//
//  Created by shashi kumar on 12/27/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SGCard.h"
#import "Deck.h"

@interface SetMatchGame : SGCard


@property (readonly, nonatomic) int score;
@property (readonly ,nonatomic) NSString *messageAfterCardsMatch;
@property (readonly, nonatomic) int correctMatchCount;
@property (readonly, nonatomic) int unCorrectMatchCount;
@property (readonly, nonatomic) NSMutableArray *flippedHistory;

- (id) initWithCardCount:(NSUInteger)count
     withDifficultyLevel:(int)currentDifficultyLevel
               usingDeck: (Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (Card *)drawRestCardForTaggedButtons:(NSUInteger)tag;
- (Card *)remainingSixtyCardAtIndex:(NSUInteger)index;
- (Card *)restTewntyCardsAtIndex:(NSUInteger)index;

@end
