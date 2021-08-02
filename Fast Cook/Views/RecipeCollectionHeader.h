//
//  RecipeCollectionHeader.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/26/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCollectionHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

NS_ASSUME_NONNULL_END
