//
//  SGPlayingCard.h
//  MatchCards
//
//  Created by shashi kumar on 12/26/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSString *suit;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
