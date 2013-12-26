//
//  SGCardDeck.m
//  MatchCards
//
//  Created by shashi kumar on 12/23/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SGCardDeck.h"
#import "SGCard.h"

@implementation SGCardDeck

- (id)init {
    self=[super init];
    if (self) {
        for (NSUInteger shades=1; shades< SGCardShadeCount; shades++) {
            for (NSUInteger color = 1; color < SGCardColorCount; color++) {
                for (NSUInteger symbol=1; symbol <SGCardSymbolCount; symbol++) {
                    for (NSUInteger i=1; i<=3; i++) {
                        SGCard *card=[[SGCard alloc] init];
                        card.symbol=symbol;
                        card.shade=shades;
                        card.color=color;
                        card.number=i;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
