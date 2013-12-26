//
//  SGCard.h
//  MatchCards
//
//  Created by shashi kumar on 12/23/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "Card.h"

typedef enum {
    SGCardSymbolSquare =1,
    SGCardSymbolDiamond=2,
    SGCardSymbolOval=3
}SGCardSymbol;

typedef enum {
    SGCardColorGreen=1,
    SGCardColorRed=2,
    SGCardColorPurple=3
}SGCardColor;

typedef enum {
    SGCardShadeSolid=1,
    SGCardShadeOpen=2,
    SGCardShadeStripe=3
}SGCardShade;


@interface SGCard : Card

@property (nonatomic) SGCardColor color;
@property (nonatomic) SGCardShade shade;
@property (nonatomic) SGCardSymbol symbol;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShades;

@end
