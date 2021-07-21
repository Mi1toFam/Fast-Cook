//
//  RecipeCell2.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/20/21.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) Recipe *recipe;


@end

NS_ASSUME_NONNULL_END
