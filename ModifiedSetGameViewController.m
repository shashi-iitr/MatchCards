//
//  ModifiedSetGameViewController.m
//  MatchCards
//
//  Created by shashi kumar on 12/26/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "ModifiedSetGameViewController.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface ModifiedSetGameViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *sgPlayingCard;
@property (nonatomic, strong) Deck *deck;
@end
@implementation ModifiedSetGameViewController

- (Deck *)deck {
    return _deck=_deck?:[[PlayingCardDeck alloc] init];
}

- (void)setSgPlayingCard:(PlayingCardView *)sgPlayingCard {
    _sgPlayingCard=sgPlayingCard;
    [self drawRandomPlayingCard];
    [sgPlayingCard addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:sgPlayingCard action:@selector(pinch:)]];
}

- (void)drawRandomPlayingCard {
    Card *card=[self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard=(PlayingCard *)card;
        self.sgPlayingCard.rank=playingCard.rank;
        self.sgPlayingCard.suit=playingCard.suit;
    }
}
- (IBAction)pinchFaceCard:(UIPinchGestureRecognizer *)sender {
    [self.sgPlayingCard pinch:sender];
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    [UIView transitionWithView:self.sgPlayingCard
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (!self.sgPlayingCard.faceUp) {
                            [self drawRandomPlayingCard];
                        }
                        self.sgPlayingCard.faceUp=!self.sgPlayingCard.faceUp;}
                    completion:NULL];
    
}

@end
