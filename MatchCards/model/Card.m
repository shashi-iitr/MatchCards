//
//  Card.m
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCard{
    int score=0;
    
    for (Card *card in otherCard) {
        if([card.contents isEqualToString:self.contents]){
            score=1;
        }
    }
    
    return score;
}


@end
