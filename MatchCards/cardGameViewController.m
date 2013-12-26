//
//  cardGameViewController.m
//  MatchCards
//
//  Created by shashi kumar on 12/11/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "cardGameViewController.h"
#import "PlayingCardDeck.h"
#import "cardMatchingGame.h"
#import "Deck.h"

@interface cardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
//connect all the cardButtons to the controller from the view
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *displayMessage;

@property (strong, nonatomic) cardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *displayCards;
@property (weak, nonatomic) IBOutlet UISegmentedControl *setDifficultyLevel;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UISlider *slidePosition; // slider.value

//@property (strong, nonatomic) NSMutableArray *flippedImageHistory;
@property (nonatomic) BOOL resetArgument;
@property (nonatomic) int currentDifficultyLevel;
@property  (strong, nonatomic) NSMutableArray *history;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

@property (nonatomic) PlayingCardDeck *deck;

@end

@implementation cardGameViewController

#pragma mark - View lifecycle
/*
- (NSMutableArray *)flippedImageHistory{
    if (!_flippedImageHistory) _flippedImageHistory=[[NSMutableArray alloc] init];
    return  _flippedImageHistory;
}
*/
- (PlayingCardDeck *)deck{
    if(!_deck) _deck=[[PlayingCardDeck alloc] init];
    return _deck;
}


- (cardMatchingGame *)game{
    if(!_game) _game=[[cardMatchingGame alloc] initWithCardCount:self.cardButtons.count withDifficultyLevel: (int)self.currentDifficultyLevel usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}


// updateUI matches the model, model will update the cardButtons eachtime
- (void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons=cardButtons;
    
    [self updateUI];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        self.game=nil;
        self.flipCount=0;
        [self updateUI];
        
        self.displayMessage.text=[NSString stringWithFormat:@"lets play!!"];
        self.displayCards.text=[NSString stringWithFormat:@"select cards to play, cheers!!"];
        
        self.historyLabel.text=@"";
        [self.slidePosition setValue:0];

    } else {
        [self.setDifficultyLevel setEnabled:YES forSegmentAtIndex:0];
        [self.setDifficultyLevel setEnabled:YES forSegmentAtIndex:1];
        self.historyLabel.alpha=0;
    }
}

#pragma mark - Update UI

//reflect model in UI and set title for selected and not selected state
- (void)updateUI{

    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha =(card.isUnplayable ? 0.5:1.0);
    }
    self.displayMessage.text=[NSString stringWithFormat:@"%@", self.game.messageFromMatch];
    self.scoreLabel.text=[NSString stringWithFormat:@"score: %d",self.game.score];
    
}


- (void)setFlipCount:(int)flipCount{
    _flipCount=flipCount;
    self.flipLabel.text=[NSString stringWithFormat:@"flips: %d", self.flipCount];
    
}


// models decide which button is in selected state
- (IBAction)flipCard:(UIButton *)sender {
    
    NSString *index=[NSString stringWithFormat:@"%d",[self.cardButtons indexOfObject:sender]];
    //[self.flippedImageHistory insertObject:index atIndex:self.flipCount];
    
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];

    self.flipCount++;
    [self.slidePosition setValue:self.flipCount animated:NO];
    self.displayCards.text=[NSString stringWithFormat:@"selected card: %@", [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]].contents];
   
    [self updateUI];
}

- (void)displayFlippedImage:(int)index{
    
    [self.game flipCardAtIndex:index];
    
    [self updateUI];
}

#pragma mark - Helpers

- (IBAction)changeDifficultyLevel:(UISegmentedControl *)sender {
    self.currentDifficultyLevel=sender.selectedSegmentIndex;
    [self resetGame:sender];
    
}


- (IBAction)resetGame:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle:@"Next Question"
                                message:@"are you sure"
                               delegate:self
                      cancelButtonTitle:@"cancel"
                      otherButtonTitles:@"OK" ,nil] show];
    
}

- (IBAction)sliderPos:(UISlider *)sender {
    if (sender.value<self.flipCount) {
        
        int index=[self.slidePosition value];
        
        self.historyLabel.text=[NSString stringWithFormat:@"%@",[self.game flippedHistorywithScrollValue:index]];
        self.historyLabel.alpha=0.5;
        
       // [self.cardButtons objectAtIndex:[self.flippedImageHistory[index] intValue]];
       // [self displayFlippedImage:[self.flippedImageHistory[index] intValue]];
        
    }
}


@end
