//
//  SetGameViewController.m
//  MatchCards
//
//  Created by shashi kumar on 12/20/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SetGameViewController.h"
#import "Card.h"
#import "cardMatchingGame.h"
#import "SGCard.h"
#import "SGCardDeck.h"

@interface SetGameViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *SGCardButtons;
@property (weak, nonatomic) IBOutlet UILabel *displayScore;
@property (weak, nonatomic) IBOutlet UILabel *rightMatch;
@property (weak, nonatomic) IBOutlet UILabel *wrongMatch;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UILabel *clickCountLabel;

@property (nonatomic) int clickCount;
@property (nonatomic, strong) cardMatchingGame *game;

@end

@implementation SetGameViewController


- (cardMatchingGame *) game {
    return _game=_game ?: [[cardMatchingGame alloc] initWithCardCount:[self.SGCardButtons count] withDifficultyLevel:1 usingDeck:[[SGCardDeck alloc] init]];
}


- (NSString *)setCardFace:(SGCard *)card {
    return card.contents;
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
        self.wrongMatch.text=@"Unmatched";
        self.rightMatch.text=@"Matched";
        self.clickCountLabel.text=@"0";
        self.clickCount=0;
        self.game=nil;
    
        for (UIButton *SGCardButton in self.SGCardButtons) {
            [SGCardButton setBackgroundColor:[UIColor whiteColor]];
        }
        [self updateSGCardButtons];
        
    }
}

#pragma mark - updateGame

- (void)setSGCardButtons:(NSArray *)SGCardButtons {
    _SGCardButtons=SGCardButtons;
    
    [self updateSGCardButtons];
}


- (void)updateSGCardButtons {
    for (UIButton *SGCardButton in self.SGCardButtons) {
        
        Card *card=[self.game cardAtIndex:[self.SGCardButtons indexOfObject:SGCardButton]];
        
        
        
        [SGCardButton setAttributedTitle:[self setSGCardSymbol:card] forState:UIControlStateNormal];
        
        SGCardButton.selected=card.isFaceUp;
        SGCardButton.enabled=!card.unplayable;
        
        if (card.unplayable) {
            
           // SGCardButton.layer.borderColor=[UIColor blackColor].CGColor;
            SGCardButton.backgroundColor=[UIColor yellowColor];
        }
    }
    
    self.displayScore.text=[NSString stringWithFormat:@"score: %d", self.game.score];
    self.rightMatch.text=[NSString stringWithFormat:@"rm: %d", self.game.correctMatchCount];
    self.wrongMatch.text=[NSString stringWithFormat:@"wm: %d", self.game.unCorrectMatchCount];
}


- (void)setClickCount:(int)clickCount {
    _clickCount=clickCount;
    self.clickCountLabel.text=[NSString stringWithFormat:@"%d",self.clickCount];
}

- (IBAction)clickSGCard:(UIButton *)sender {
    self.clickCount++;
    
    [self.game flipCardAtIndex:[self.SGCardButtons indexOfObject:sender]];
    [self updateSGCardButtons];
    
}

#pragma mark - attribute To SGCardButtons


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
            case SGCardSymbolOval:
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
        
        
        double alphaComponent;
        switch (sgCard.shade) {
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
        
    }
    
    return attributedString;
}



@end
