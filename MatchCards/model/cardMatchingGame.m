//
//  cardMatchingGame.m
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "cardMatchingGame.h"


@interface cardMatchingGame()

@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *messageAfterCardsMatch;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) int gameDifficulty;
@property (nonatomic, strong) NSMutableArray *flippedHistory;

@property (nonatomic) int positionOfMatchedCardView;
@property (nonatomic, readwrite) int correctMatchCount;
@property (nonatomic, readwrite) int unCorrectMatchCount;

@end

@implementation cardMatchingGame

#define MATCH_PENALTY 2
#define MATCH_BONUS 4
#define FLIP_COST 1

#pragma mark - initialization

- (id)initWithCardCount:(NSUInteger)count withDifficultyLevel:(int)currentDifficultyLevel usingDeck:(Deck *)deck {
    self=[super init];
    if (self) {
        self.gameDifficulty=currentDifficultyLevel;
        for (int i=0; i<count; i++) {
            Card *card=[deck drawRandomCard];
            if(card){
                self.cards[i]=card;
                
            }else{
                self.cards=nil;
                break;
            }
        }
    }
    return self;
}


- (NSMutableArray *)cards{
    if(!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}


- (NSMutableArray *)flippedHistory{
    if(!_flippedHistory) _flippedHistory=[[NSMutableArray alloc] init];
    return _flippedHistory;
}


- (NSString *)flippedHistorywithScrollValue:(int)index{
    
    return self.flippedHistory[index] ;
}

#pragma mark - match cards

- (void)flipCardAtIndex:(NSUInteger)index{
    
    if(self.gameDifficulty==0){
        [self flipTwoCardAtIndex:index];
    } else if (self.gameDifficulty==1) {
        [self flipThreeCardAtIndex:index];
    }
}


- (void)flipTwoCardAtIndex:(NSUInteger)index{
    Card *card=[self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if (!card.faceUp) {
            BOOL didFindAnOpenCard = NO;
            
            for (Card *otherCard in self.cards) {
                
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    didFindAnOpenCard = YES;
                    
                    
                    int matchScore=[card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable=YES;
                        otherCard.unplayable=YES;
                        self.score+=matchScore*MATCH_BONUS;
                        self.messageAfterCardsMatch=[NSString stringWithFormat:@"Matched %@ & %@ for points %d",card.contents, otherCard.contents, MATCH_BONUS];
                        
                    } else {
                        otherCard.faceUp=NO;
                        self.score-=MATCH_PENALTY;
                        self.messageAfterCardsMatch=[NSString stringWithFormat:@"%@ and %@ didn't match! %d points penalty", card.contents, otherCard.contents, MATCH_PENALTY];
                        
                    }
                    
                    break;
                }
            }
            
            if (!didFindAnOpenCard) {
                self.messageAfterCardsMatch=[NSString stringWithFormat:@"flipped card is %@", card.contents];
                           }
            
            self.score-=FLIP_COST;
            
            [self.flippedHistory insertObject:self.messageAfterCardsMatch atIndex:self.positionOfMatchedCardView];
            self.positionOfMatchedCardView++;
        }
        card.faceUp=!card.isFaceUp;
    }
}



- (void)flipThreeCardAtIndex:(NSUInteger)index{
    
    Card *card=[self cardAtIndex:index];
    if (card && !card.isUnplayable) {
        if(!card.isFaceUp){
            BOOL didFindAnOpenCard = NO;
            
            
            NSMutableArray *otherCard=[[NSMutableArray alloc] init];
            Card *chekingCard;
            for(chekingCard in self.cards){
                if (chekingCard.isFaceUp && !chekingCard.isUnplayable){
                    [otherCard addObject:chekingCard];
                    didFindAnOpenCard = YES;
                    
                    if (otherCard.count==2) {
                        Card *card1=otherCard[0];
                        Card *card2=otherCard[1];
                        
                        int matchScore=[card match:otherCard];
                        if (matchScore) {
                            card.unplayable=YES;
                            card1.unplayable=YES;
                            card2.unplayable=YES;
                            
                            self.score+=matchScore*MATCH_BONUS;
                            self.messageAfterCardsMatch=[NSString stringWithFormat:@"Matched %@, %@ & %@for points %d",card.contents, card1.contents, card2.contents, MATCH_BONUS];
                            self.correctMatchCount++;
                            break;
                    
                        } else if (!matchScore) {
                            card1.faceUp=NO;
                            card2.faceUp=NO;
                            
                            self.score-=MATCH_PENALTY;
                            self.messageAfterCardsMatch=[NSString stringWithFormat:@"%@, %@ and %@ didn't match! %d points penalty", card.contents, card1.contents, card2.contents, MATCH_PENALTY];
                            self.unCorrectMatchCount++;
                            break;
                        
                        }
                    }
                }
            }
            
            if (!didFindAnOpenCard) {
                self.messageAfterCardsMatch=[NSString stringWithFormat:@"flipped card: %@", card.contents];
            }
            
            self.score-=FLIP_COST;
            [self.flippedHistory insertObject:self.messageAfterCardsMatch atIndex:self.positionOfMatchedCardView];
            self.positionOfMatchedCardView++;
    
        }
         card.faceUp=!card.isFaceUp;
    }
}


- (Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count])?self.cards[index]: nil;
}

@end
