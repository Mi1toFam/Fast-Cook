//
//  Recipe.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/14/21.
//

#import "Recipe.h"

@implementation Recipe

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"title"];
        self.poster = dictionary[@"image"];
    }
    
    return self;
}

@end
