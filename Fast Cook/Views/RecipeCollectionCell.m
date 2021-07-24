//
//  RecipeCollectionCell.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/21/21.
//

#import "RecipeCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@implementation RecipeCollectionCell

- (void)refreshData {
    self.nameLabel.text = self.recipe[@"name"];
    NSURL *posterURL = [NSURL URLWithString:self.recipe[@"image"]];
    self.posterView.image = nil;
    [self.posterView setImageWithURL:posterURL];
    self.timeLabel.text = self.recipe[@"readyTime"];
}

@end
