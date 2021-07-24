//
//  UserRecipe.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/21/21.
//

#import "UserRecipe.h"

@implementation UserRecipe

@dynamic recipeID;
@dynamic author;

@dynamic name;
@dynamic readyTime;
@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"Recipe";
}

+ (void) postRecipeWithImage: ( NSString * _Nullable )image withName: ( NSString * _Nullable )name withTime: ( NSString * _Nullable )time withID: ( NSString * _Nullable )recipeID {
    UserRecipe *newRecipe = [UserRecipe new];
    newRecipe.image = image;
    PFUser *user = [PFUser currentUser];
    newRecipe.author = user;
    newRecipe.name = name;
    newRecipe.recipeID = recipeID;
    newRecipe.readyTime = time;
    
    [newRecipe saveInBackgroundWithBlock: nil];
}

@end
