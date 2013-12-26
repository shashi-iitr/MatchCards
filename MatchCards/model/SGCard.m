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



- (NSAttributedString *)attributedSymbol {
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:@""];
    
    NSMutableAttributedString *symbol = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (int i=1; i<=self.number; i++) {
        switch (self.symbol) {
            case SGCardSymbolDiamond:
                [symbol appendAttributedString:[[NSAttributedString alloc] initWithString:[@"" stringByPaddingToLength:1 withString:@"❢" startingAtIndex:0]]];
                break;
            case SGCardSymbolSquare:
                [symbol appendAttributedString:[[NSAttributedString alloc] initWithString:[@"" stringByPaddingToLength:1 withString:@"■" startingAtIndex:0]]];
                break;
            case SGCardSymbolCircle:
                [symbol appendAttributedString:[[NSAttributedString alloc] initWithString:[@"" stringByPaddingToLength:1 withString:@"●" startingAtIndex:0]]];
                break;
                
            default:
                break;
        }
    }
    
    [attributedString appendAttributedString:symbol];
    
    UIColor *color;
    switch (self.color) {
        case SGCardColorGreen:
            color=[UIColor greenColor];
            break;
            
        case SGCardColorPurple:
            color=[UIColor purpleColor];
            break;
            
        case SGCardColorRed:
            color=[UIColor redColor];
            break;
            
        default:
            break;
    }
    
    [attributedString addAttributes:@{NSStrokeColorAttributeName: color} range: NSMakeRange(0, [attributedString string].length)];
    
    
    double alphaComponent=0.0;
    switch (self.shade) {
        case SGCardShadeOpen:
            [attributedString addAttributes:@{NSStrokeWidthAttributeName: @-4} range:NSMakeRange(0, [attributedString string].length)];
            [attributedString addAttributes:@{NSStrokeColorAttributeName:color} range: NSMakeRange(0, [attributedString string].length)];
            alphaComponent=0.0;
            break;
        case SGCardShadeSolid:
            alphaComponent=1.0;
            break;
        case SGCardShadeStripe:
            alphaComponent=0.4;
            break;
            
        default:
            break;
    }
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName: [color colorWithAlphaComponent:alphaComponent]} range: NSMakeRange(0, [attributedString string].length)];
    
    
    return attributedString;
}

@end
