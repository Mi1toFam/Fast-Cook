//
//  UserRecipe.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/21/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserRecipe : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *recipeID;
@property (strong, nonatomic) PFUser *author;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *readyTime;
@property (strong, nonatomic) NSString *image;

+ (void) postRecipeWithImage: ( NSString * _Nullable )image withName: ( NSString * _Nullable )name withTime: ( NSString * _Nullable )time withID: ( NSString * _Nullable )recipeID;

@end

NS_ASSUME_NONNULL_END
