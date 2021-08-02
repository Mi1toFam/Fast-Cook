//
//  APIManager.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/26/21.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (instancetype)shared;

- (void)getAutocompleteWithURL: ( NSString * _Nullable )link withCompletion:(void(^)(NSArray *searches, NSError *error))completion;

- (void)getRecipesWithURL: ( NSString * _Nullable )link withCompletion:(void(^)(NSArray *recipes, NSError *error))completion;

- (void)getSpecificRecipeWithURL: ( NSString * _Nullable )link withCompletion:(void(^)(NSDictionary *recipe, NSError *error))completion;

- (void)getSavedRecipesWithID: ( NSString *_Nullable)recipeID withCompletion:(void(^)(NSArray *recipes, NSError *error))completion;



@end

NS_ASSUME_NONNULL_END
