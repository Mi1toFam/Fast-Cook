//
//  DetailsViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/15/21.
//

#import "DetailsViewController.h"
#import "UserRecipe.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()

@property (strong, nonatomic) NSDictionary *recipe;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *missingIngredientsLabel;
@property (weak, nonatomic) IBOutlet UITextView *instructionsView;

@end

@implementation DetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addButton.layer.cornerRadius = 40;
    
    [[APIManager shared] getSavedRecipesWithID:self.iD withCompletion:^(NSArray *recipes, NSError *error) {
        if (recipes.count != 0) {
            self.addButton.backgroundColor = [UIColor redColor];
            [self.addButton setTitle:@"Remove" forState:UIControlStateNormal];
        }
        else {
            self.addButton.backgroundColor = [UIColor blueColor];
            [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        }
    }];

    [self fetchRecipe];
}

-(void)fetchRecipe {
    NSString *startURL = @"https://api.spoonacular.com/recipes/";
    NSString *middleURL = [startURL stringByAppendingString:self.iD];
    middleURL = [middleURL stringByAppendingString:@"/information?apiKey="];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Info" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    id key = [dict objectForKey: @"API_KEY"];
    NSString *fullURL = [middleURL stringByAppendingString:key];
    [[APIManager shared] getSpecificRecipeWithURL:fullURL withCompletion:^(NSDictionary *recipe, NSError *error) {
        if (recipe) {
            self.recipe = recipe;
            
            self.titleLabel.text = recipe[@"title"];
            
            NSNumber *timeData = recipe[@"readyInMinutes"];
            NSString *time = [[timeData stringValue] stringByAppendingString:@" minutes"];
            self.timeLabel.text = time;
            
            NSNumber *servingsData = recipe[@"servings"];
            NSString *servings = [@"Servings: " stringByAppendingString:[servingsData stringValue]];
            self.servingsLabel.text = servings;
            
            NSURL *posterURL = [NSURL URLWithString:recipe[@"image"]];
            self.posterView.image = nil;
            [self.posterView setImageWithURL:posterURL];
            
            NSString *ingredients = @"Ingredients: \n- ";
            for (NSDictionary *ingrArray in recipe[@"extendedIngredients"]) {
                NSString *ingrName = ingrArray[@"original"];
                NSString *fullIngr = [ingrName stringByAppendingString:@"\n- "];
                ingredients = [ingredients stringByAppendingString:fullIngr];
            }
            ingredients= [ingredients substringToIndex:(ingredients.length - 3)];
            self.ingredientsLabel.text = ingredients;
            
            NSString *instructions = recipe[@"instructions"];
            @try {
               NSString *details = @"Instructions below are retrieved from another website, and may be slightly different from the primary source. Get full details here. \n\n";
                NSMutableAttributedString *webInstructions = [[NSMutableAttributedString alloc] initWithString:details];
                NSString *url = recipe[@"sourceUrl"];
                [webInstructions addAttribute:NSLinkAttributeName value:url range:NSMakeRange(webInstructions.length - 8, 4)];
                
                if ([[instructions substringToIndex:1]  isEqual: @"<"]) {
                    instructions = [instructions stringByReplacingOccurrencesOfString:@"<li>" withString:@""];
                    instructions = [instructions stringByReplacingOccurrencesOfString:@"</li>" withString:@"\n"];
                    NSRange range = NSMakeRange(4, instructions.length-9);
                    instructions = [instructions substringWithRange:range];
                }
                else {
                    instructions = [instructions stringByReplacingOccurrencesOfString:@"." withString:@".\n"];
                }
                
                NSAttributedString *newInstructions = [[NSAttributedString alloc] initWithString:instructions];
                UIFont *font = [UIFont fontWithName:@"Chalkboard SE" size:16];
                [webInstructions appendAttributedString:newInstructions];
                [webInstructions addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, webInstructions.length)];
                self.instructionsView.attributedText = webInstructions;
            }
            @catch (id anException) {
                instructions = @"No instructions available. Get full details here.";
                NSMutableAttributedString *newInstructions = [[NSMutableAttributedString alloc] initWithString:instructions];
                NSString *url = recipe[@"sourceUrl"];
                [newInstructions addAttribute:NSLinkAttributeName value:url range:NSMakeRange(newInstructions.length - 5, 4)];
                
                UIFont *font = [UIFont fontWithName:@"Chalkboard SE" size:16];
                [newInstructions addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, newInstructions.length)];
                
                self.instructionsView.attributedText = newInstructions;
            }
        }
        else {
            NSLog(@"😫😫😫 Error getting recipes: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)addOrRemove:(id)sender {
    [[APIManager shared] getSavedRecipesWithID:self.iD withCompletion:^(NSArray *recipes, NSError *error) {
        if (recipes.count != 0) {
            for (PFObject *object in recipes) {
                [object deleteInBackground];
            }
            
            self.addButton.backgroundColor = [UIColor blueColor];
            [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        }
        else {
            [UserRecipe postRecipeWithImage:self.recipe[@"image"] withName:self.titleLabel.text withTime:self.timeLabel.text withID:self.iD];
            
            self.addButton.backgroundColor = [UIColor redColor];
            [self.addButton setTitle:@"Remove" forState:UIControlStateNormal];
        }
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
