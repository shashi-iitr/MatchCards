//
//  PlayingCard.m
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCard{
    int score=0;
    
    if(otherCard.count==1){
        PlayingCard *othercard=[otherCard lastObject];
        if([othercard.suit isEqualToString:self.suit]){
            score=1;
        } else if(othercard.rank == self.rank){
            score=4;
        }
        
    } else if(otherCard.count==2){
        PlayingCard *firstCard=otherCard[0];
        PlayingCard *secondCard=otherCard[1];
        
        if([firstCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit])
        {
            score=4;
            
        } else if(firstCard.rank==self.rank && secondCard.rank==self.rank){
            score=8;
        }
    }
    return score;
}


- (NSString *)contents{
    NSArray *rankString = [PlayingCard rankString];
    return ([rankString[self.rank] stringByAppendingString:self.suit]);
    
}

@synthesize suit= _suit;

#pragma mark - setter and getter

+ (NSArray *)rankString{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSArray *)validSuits{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *) suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}

+ (NSUInteger)maxRank{
    return [self rankString].count-1;
}

- (NSString *)suit{
    return _suit ? _suit :@"?";
}

- (void)setRank:(NSUInteger)rank{
    if(rank<=[PlayingCard maxRank]){
        _rank=rank;
    }
}

@end
