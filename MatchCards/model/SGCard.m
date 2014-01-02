//
//  SGCard.m
//  MatchCards
//
//  Created by shashi kumar on 12/23/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SGCard.h"


@implementation SGCard

- (NSString *)contents {
    return [NSString stringWithFormat:@"%d%d%d%d",self.symbol, self.shade, self.color, self.number];
}


- (int)match:(NSArray *)otherCard {
    int score=0;
    
    if (otherCard.count==2) {
        SGCard *firstCard=otherCard[0];
        SGCard *secondCard=otherCard[1];
        
        if ((((self.number==firstCard.number) && (firstCard.number==secondCard.number) && (secondCard.number==self.number)) || ((self.number!=firstCard.number) && (firstCard.number!=secondCard.number) && (secondCard.number!=self.number)))
            
            &&
            
           (((self.color==firstCard.color) && (firstCard.color==secondCard.color) && (secondCard.color==self.color)) || ((self.color!=firstCard.color) && (firstCard.color!=secondCard.color) && (secondCard.color!=self.color)))
            
            &&
            
            (((self.symbol==firstCard.symbol) && (firstCard.symbol==secondCard.symbol) && (secondCard.symbol==self.symbol)) ||
            ((self.symbol!=firstCard.symbol) && (firstCard.symbol!=secondCard.symbol) && (secondCard.symbol!=self.symbol)))
            
            &&
            (((self.shade==firstCard.shade) && (firstCard.shade==secondCard.shade) && (secondCard.shade==self.shade)) ||
             ((self.shade!=firstCard.shade) && (firstCard.shade!=secondCard.shade) && (secondCard.shade!=self.shade)))) {
                score=4;
            
            }
    }
    
    return score;
}




@end
