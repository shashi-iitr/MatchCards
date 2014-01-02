//
//  SetGameViewController.m
//  MatchCards
//
//  Created by shashi kumar on 12/20/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SetGameViewController.h"
#import "Card.h"
#import "SGCard.h"
#import "SGCardDeck.h"
#import "SetMatchGame.h"

@interface SetGameViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *SGCardButtons;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *SGOptionCardButtons;


@property (weak, nonatomic) IBOutlet UILabel *displayScore;
@property (weak, nonatomic) IBOutlet UILabel *rightMatch;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UILabel *clickCountLabel;

@property (nonatomic) BOOL isDisplayOption;
@property (nonatomic) int clickCount;
@property (nonatomic, strong) SetMatchGame *setGame;


@end

@implementation SetGameViewController

#pragma mark - lasy Initialise

- (SetMatchGame *)setGame {
    return _setGame=_setGame?: [[SetMatchGame alloc] initWithCardCount:20 withDifficultyLevel:1 usingDeck:[[SGCardDeck alloc] init]];

}

- (NSString *)setCardFace:(SGCard *)card {
    return card.contents;
}


#pragma mark - updateGame

- (void)setSGCardButtons:(NSArray *)SGCardButtons {
    _SGCardButtons=SGCardButtons;
    for (UIButton *SGOptionButton in self.SGOptionCardButtons) {
        SGOptionButton.alpha=0.0;
    }
    [self updateSGCardButtons];
}


- (void)updateSGCardButtons {
    for (UIButton *SGCardButton in self.SGCardButtons) {
        
        Card *card=[self.setGame cardAtIndex:[self.SGCardButtons indexOfObject:SGCardButton]];
        
        
        [SGCardButton setAttributedTitle:[self setSGCardSymbol:card] forState:UIControlStateNormal];
        
        SGCardButton.selected=card.isFaceUp;
        SGCardButton.enabled=!card.unplayable;
        
        if (card.unplayable) {
            SGCardButton.backgroundColor=[UIColor yellowColor];
        }
    }
    Card *tempCard=[self.setGame cardAtIndex:16];
    if (tempCard) {
        for (UIButton *SGOptionButton in self.SGOptionCardButtons) {
            
            Card *card=[self.setGame cardAtIndex:SGOptionButton.tag+16];
            
            
            [SGOptionButton setAttributedTitle:[self setSGCardSymbol:card] forState:UIControlStateNormal];
            
            SGOptionButton.selected=card.isFaceUp;
            SGOptionButton.enabled=!card.unplayable;
            if (card.unplayable) {
                SGOptionButton.backgroundColor=[UIColor yellowColor];
                
            }
        }
    } else self.rightMatch.text=@"empty";
    self.displayScore.text=[NSString stringWithFormat:@"score: %d", self.setGame.score];
    
}

#pragma mark - actions on Buttons
- (void)setClickCount:(int)clickCount {
    _clickCount=clickCount;
    self.clickCountLabel.text=[NSString stringWithFormat:@"%d",self.clickCount];
}

- (IBAction)clickSGCard:(UIButton *)sender {
    self.clickCount++;
    
    [self.setGame flipCardAtIndex:[self.SGCardButtons indexOfObject:sender]];
   
    [self updateSGCardButtons];
}


- (IBAction)displayOptionButton:(UIButton *)sender {
    
    for (UIButton *SGOptionButton in self.SGOptionCardButtons) {
        SGOptionButton.alpha=1.0;
    }
    int i=0;
    for (UIButton *SGOptionButton in self.SGOptionCardButtons) {
        Card *card1=[self.setGame drawRestCardForTaggedButtons:i];
        
        [SGOptionButton setAttributedTitle:[self setSGCardSymbol:card1] forState:UIControlStateNormal];
        SGOptionButton.selected=card1.isFaceUp;
        SGOptionButton.enabled=!card1.unplayable;
        SGOptionButton.backgroundColor=[UIColor clearColor];
        SGOptionButton.tag=i;
        i++;
    }
}

- (IBAction)clickOptionCard:(UIButton *)sender {
    
    self.clickCount++;
    [self.setGame flipCardAtIndex:sender.tag+16];
    sender.selected=!sender.selected;
    [self updateSGCardButtons];
}


#pragma mark - provide attributed symbols


- (NSAttributedString *)setSGCardSymbol:(Card*)card {
    
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:@""];
    if ([card isKindOfClass:[SGCard class]]) {
        SGCard *sgCard=(SGCard *)card;
        
        
        NSMutableAttributedString *symbol = [[NSMutableAttributedString alloc] initWithString:@""];
        
        
        switch (sgCard.symbol) {
            case SGCardSymbolDiamond:
                [symbol appendAttributedString:[[NSAttributedString alloc] initWithString:[@"" stringByPaddingToLength:sgCard.number withString:@"❢" startingAtIndex:0]]];
                break;
            case SGCardSymbolSquare:
                [symbol appendAttributedString:[[NSAttributedString alloc] initWithString:[@"" stringByPaddingToLength:sgCard.number withString:@"■" startingAtIndex:0]]];
                break;
            case SGCardSymbolCircle:
                [symbol appendAttributedString:[[NSAttributedString alloc] initWithString:[@"" stringByPaddingToLength:sgCard.number withString:@"●" startingAtIndex:0]]];
                break;
                
            default:
                break;
        }
        
        [attributedString appendAttributedString:symbol];
        
        
        UIColor *color;
        switch (sgCard.color) {
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
        
        [attributedString addAttributes:@{NSStrokeColorAttributeName: color} range: NSMakeRange(0, [attributedString string].length )];
        
        
        double alphaComponent=0.0;
        switch (sgCard.shade) {
            case SGCardShadeOpen:
                [attributedString addAttributes:@{NSStrokeWidthAttributeName: @-4} range:NSMakeRange(0, [attributedString string].length)];
                alphaComponent=0.0;
                break;
            case SGCardShadeSolid:
                alphaComponent=1.0;
                break;
            case SGCardShadeStripe:
                alphaComponent=0.4;
                [attributedString addAttributes:@{NSStrokeWidthAttributeName: @-10,NSUnderlineStyleAttributeName:@(NSUnderlineStyleDouble)} range:NSMakeRange(0, [attributedString string].length)];
                break;
                
            default:
                break;
        }
        
        [attributedString addAttributes:@{NSForegroundColorAttributeName: [color colorWithAlphaComponent:alphaComponent]} range: NSMakeRange(0, [attributedString string].length)];
        
    }
    
    return attributedString;
}

#pragma mark - reset

- (IBAction)resetDisplayAlert:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"reset"
                                message:@"confirm by pressing"
                               delegate:self
                      cancelButtonTitle:@"cancel"
                      otherButtonTitles:@"ok", nil] show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        self.displayScore.text=@"Score: ";
        self.rightMatch.text=@"Matched";
        self.clickCountLabel.text=@"0";
        self.clickCount=0;
        self.setGame=nil;
        
        for (UIButton *SGCardButton in self.SGCardButtons) {
            [SGCardButton setBackgroundColor:[UIColor whiteColor]];
        }
        
        for (UIButton *SGOptionButton in self.SGOptionCardButtons) {
            SGOptionButton.alpha=0.0;
        }
        
        for (UIButton *SGOptionButton in self.SGOptionCardButtons) {
        }
        [self updateSGCardButtons];
        
    }
}


@end
