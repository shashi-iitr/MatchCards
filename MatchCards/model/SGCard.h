//
//  SGCard.h
//  MatchCards
//
//  Created by shashi kumar on 12/23/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "Card.h"

typedef NS_ENUM(NSUInteger, SGCardSymbol) {
    SGCardSymbolSquare =1,
    SGCardSymbolDiamond,
    SGCardSymbolCircle,
    SGCardSymbolCount
};

typedef NS_ENUM(NSUInteger, SGCardColor) {
    SGCardColorGreen=1,
    SGCardColorRed,
    SGCardColorPurple,
    SGCardColorCount
};

typedef NS_ENUM(NSUInteger,SGCardShade) {
    SGCardShadeSolid=1,
    SGCardShadeOpen,
    SGCardShadeStripe,
    SGCardShadeCount
};

@interface SGCard : Card

@property (nonatomic) SGCardColor color;
@property (nonatomic) SGCardShade shade;
@property (nonatomic) SGCardSymbol symbol;
@property (nonatomic) NSUInteger number;


@end
