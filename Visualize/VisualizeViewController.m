//
//  VisualizeViewController.m
//  Visualize
//
//  Created by Corinne Krych on 5/16/13.
//  Copyright (c) 2013 Corinne Krych. All rights reserved.
//

#import "VisualizeViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface VisualizeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation VisualizeViewController

- (CardMatchingGame *)game {
    NSLog(@"Init game");
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) updateUI {
    NSLog(@"updateUI..");
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 :1.0;
    }
    [self.score setText:[NSString stringWithFormat:@"Score : %d", self.game.score]];
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips : %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    NSLog(@"flipcard..");
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}



@end
