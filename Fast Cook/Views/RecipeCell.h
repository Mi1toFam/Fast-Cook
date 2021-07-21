//
//  RecipeCell.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/14/21.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCell : UITableViewCell

@property (strong, nonatomic) Recipe *recipe;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
