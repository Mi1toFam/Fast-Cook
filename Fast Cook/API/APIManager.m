//
//  APIManager.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/26/21.
//

#import "APIManager.h"

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(void)getAutocompleteWithURL:(NSString *)link withCompletion:(void (^)(NSArray *searches, NSError * error))completion {
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error != nil) {
           completion(nil, error);
       }
       else {
           NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           NSArray *searches = dataArray;
           completion(searches, nil);
       }
    }];
    
    [task resume];
}

- (void)getRecipesWithURL:(NSString *)link withCompletion:(void (^)(NSArray *recipes, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error != nil) {
           completion(nil, error);
       }
       else {
           NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           NSArray *recipes = dataDictionary[@"results"];
           completion(recipes, nil);
       }
    }];
    
    [task resume];
}

- (void)getSpecificRecipeWithURL:(NSString *)link withCompletion:(void (^)(NSDictionary * recipe, NSError * error))completion {
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error != nil) {
           completion(nil, error);
       }
       else {
           NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           NSDictionary *recipe = dataDictionary;
           completion(recipe, nil);
       }
    }];
    
    [task resume];
}

- (void)getSavedRecipesWithID: (NSString *)recipeID withCompletion:(void (^)(NSArray * recipes, NSError * error))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    if (recipeID) {
        [query whereKey:@"recipeID" equalTo: recipeID];
    }
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
        if (recipes != nil) {
            // do something with the array of object returned by the call
            completion(recipes, nil);
        } else {
            completion(nil, error);
        }
    }];
    
}
@end
