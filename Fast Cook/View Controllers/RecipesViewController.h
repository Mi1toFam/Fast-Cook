//
//  RecipesViewController.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/14/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipesViewController : UIViewController

@property (strong, nonatomic) NSString *isVegan;
@property (strong, nonatomic) NSString *isVegetarian;
@property (strong, nonatomic) NSString *maxReadyTime;

@end

NS_ASSUME_NONNULL_END
