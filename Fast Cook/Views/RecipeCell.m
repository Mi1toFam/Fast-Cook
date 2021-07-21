//
//  RecipeCell.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/14/21.
//

#import "RecipeCell.h"
#import "UIImageView+AFNetworking.h"

@implementation RecipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData{
    self.nameLabel.text = self.recipe.name;
    NSURL *posterURL = [NSURL URLWithString:self.recipe.poster];
    self.posterView.image = nil;
    [self.posterView setImageWithURL:posterURL];
}

@end
