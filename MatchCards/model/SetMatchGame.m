//
//  SetMatchGame.m
//  MatchCards
//
//  Created by shashi kumar on 12/27/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SetMatchGame.h"
#import "SGCard.h"

@interface SetMatchGame ()

@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *messageAfterCardsMatch;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) int gameDifficulty;

@property (nonatomic) NSMutableArray *totalTwentyCArds;
@property (nonatomic) NSMutableArray *remainingSixtyOneCards;
@property (nonatomic) NSMutableArray *fourCards;

@property (nonatomic, readwrite) int correctMatchCount;
@property (nonatomic, readwrite) int unCorrectMatchCount;

@end

@implementation SetMatchGame

#define MATCH_PENALTY 2
#define MATCH_BONUS 4
#define FLIP_COST 1

#pragma mark - initializations

- (NSMutableArray *) fourCards {
    return _fourCards=_fourCards?:[[NSMutableArray alloc] init];
}

- (NSMutableArray *)totalTwentyCArds {
    return _totalTwentyCArds=_totalTwentyCArds?:[[NSMutableArray alloc] init];
}

- (NSMutableArray *)remainingSixtyOneCards {
    return _remainingSixtyOneCards=_remainingSixtyOneCards?:[[NSMutableArray alloc] init];
}

- (id)initWithCardCount:(NSUInteger)count withDifficultyLevel:(int)currentDifficultyLevel usingDeck:(Deck *)deck {
    self=[super init];
    if (self) {
        self.gameDifficulty=currentDifficultyLevel;
        for (int i=0; i<16; i++) {
            Card *card=[deck drawRandomCard];
            if(card){
                self.cards[i]=card;
                //self.fullCards[i]=card;
            }else{
                self.cards=nil;
                //self.fullCards=nil;
                break;
            }
        }
        
        Card *card1=[deck drawRandomCard];
        int i=0;
        while (card1) {
            self.remainingSixtyOneCards[i]=card1;
            //self.cards[i+count]=card1;
            card1=[deck drawRandomCard];
            i++;
        }
    }
    return self;
}


- (NSMutableArray *)cards{
    if(!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

#pragma mark - match the 20 cards

- (void)flipCardAtIndex:(NSUInteger)index{
    
    for (int i=0; i<20; i++) {
        if (i<16) {
            self.totalTwentyCArds[i]=self.cards[i];
        } else if (self.fourCards.count) {
            self.totalTwentyCArds[i]=self.fourCards[i-16];
        }
    }
    
    Card *card=[self cardAtIndex:index];
    if (card && !card.isUnplayable) {
        if(!card.isFaceUp){
            BOOL didFindAnOpenCard = NO;
            
            
            NSMutableArray *otherCard=[[NSMutableArray alloc] init];
            Card *chekingCard;
            for(chekingCard in self.totalTwentyCArds){
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
                            self.messageAfterCardsMatch=[NSString stringWithFormat:@"%@,%@,%@", card.contents, card1.contents, card2.contents];
                            self.correctMatchCount++;
                            break;
                            
                        } else if (!matchScore) {
                            card1.faceUp=NO;
                            card2.faceUp=NO;
                            
                            self.score-=MATCH_PENALTY;
                            self.messageAfterCardsMatch=@"unmatched";
                            self.unCorrectMatchCount++;
                            break;
                            
                        }
                    }
                }
            }
            
            if (!didFindAnOpenCard) {
                self.messageAfterCardsMatch=@"flipped card";
            }
            
            self.score-=FLIP_COST;
            
        }
        card.faceUp=!card.isFaceUp;
    }
}

#pragma mark - return cards

- (Card *)cardAtIndex:(NSUInteger)index {
    if (index< self.cards.count) {
       return  self.cards[index];
    } else if (self.totalTwentyCArds.count >16) {
        return self.totalTwentyCArds[index];
    }
    return nil;
}


- (Card *)remainingSixtyCardAtIndex:(NSUInteger)index {
    return self.remainingSixtyOneCards.count>index?self.remainingSixtyOneCards[index]:nil;
}

- (Card *)restTewntyCardsAtIndex:(NSUInteger)index {
    return self.totalTwentyCArds.count>index?self.totalTwentyCArds[index]:nil;
}

- (Card *)drawRestCardForTaggedButtons:(NSUInteger)tag {
    Card *randomCard=nil;
    unsigned index;
    
    if (self.remainingSixtyOneCards.count) {
        index=arc4random()%self.remainingSixtyOneCards.count;
        randomCard=self.remainingSixtyOneCards[index];
        [self.remainingSixtyOneCards removeObjectAtIndex:index];
        [self.fourCards insertObject:randomCard atIndex:tag];
    } 
    
    return randomCard;
    
}


@end
