//
//  SearchViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/13/21.
//

#import "SearchViewController.h"
#import "RecipesViewController.h"
#import "IngredientsViewController.h"
#import "APIManager.h"
#import "RecipeSearchCell.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *readyField;
@property (weak, nonatomic) IBOutlet UISwitch *isVegetarian;
@property (weak, nonatomic) IBOutlet UISwitch *isVegan;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *ingredientsButton;
@property (weak, nonatomic) IBOutlet UIButton *recipeSearchButton;
@property (weak, nonatomic) IBOutlet UITextField *recipeField;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) NSArray *searches;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchButton.layer.cornerRadius = 25;
    self.recipeSearchButton.layer.cornerRadius = 30;
    self.ingredientsButton.layer.cornerRadius = 20;
    
    [self.searchTableView setHidden:TRUE];
    
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    if (self.ingredients == nil) {
        self.ingredients = [[NSArray alloc] init];
    }
    else if (self.ingredients.count != 0) {
        NSString *label = [@"Add/Remove Ingredients (" stringByAppendingString:[@(self.ingredients.count) stringValue]];
        label = [label stringByAppendingString:@" total)"];
        [self.ingredientsButton setTitle:label forState:UIControlStateNormal];
    }
    else {
        [self.ingredientsButton setTitle:@"Start Adding Ingredients" forState:UIControlStateNormal];
    }
        
    [self.recipeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidChange :(UITextField *) textField{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performAutocomplete) object:nil];
    [self performSelector:@selector(performAutocomplete) withObject:nil afterDelay:0.3];
}

-(void)performAutocomplete{
    if (self.recipeField.text.length == 0) {
        [self.searchTableView setHidden:TRUE];
    }
    else {
        [self.searchTableView setHidden:FALSE];
        NSString *link = [@"https://api.spoonacular.com/recipes/autocomplete?apiKey=68c1462cdfc64471a3c2df51555225be&number=10&query=" stringByAppendingString:self.recipeField.text];
        [[APIManager shared] getAutocompleteWithURL:link withCompletion:^(NSArray *searches, NSError *error) {
            if (searches) {
                self.searches = searches;
                
                [self.searchTableView reloadData];
            }
            else {
                NSLog(@"😫😫😫 Error getting recipes: %@", error.localizedDescription);
            }
        }];
    }
}

- (IBAction)touchDown:(id)sender {
    [self buttonScaleAnimation: self.recipeSearchButton];
}

- (IBAction)advancedTouchDown:(id)sender {
    [self buttonScaleAnimation: self.searchButton];
}

-(void)buttonScaleAnimation:(UIButton *)sender {
    float animationDuration = 0.25;
    // Increase scale to 1.25 with animation
    [UIView animateWithDuration:animationDuration animations:^{
        sender.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        // Return to original scale with animation
        [UIView animateWithDuration:animationDuration animations:^{
            sender.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            sender.transform = CGAffineTransformIdentity;
        }];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"advancedSegue"]) {
        RecipesViewController *recipesViewController = [segue destinationViewController];
        if ([self.isVegan isOn]) {
            recipesViewController.isVegan = @"vegan";
        }
        else if ([self.isVegetarian isOn]) {
            recipesViewController.isVegetarian = @"vegetarian";
        }
        recipesViewController.maxReadyTime = self.readyField.text;
        
        recipesViewController.titleMatch = self.recipeField.text;
        
        recipesViewController.ingredients = self.ingredients;
    }
    else if ([segue.identifier isEqual:@"recipeSegue"]) {
        RecipesViewController *recipesViewController = [segue destinationViewController];
        
        recipesViewController.titleMatch = self.recipeField.text;
    }
    else {
        IngredientsViewController *ingredientsViewController = [segue destinationViewController];
        
        ingredientsViewController.ingredients = [self.ingredients mutableCopy];        
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecipeSearchCell *cell = [self.searchTableView dequeueReusableCellWithIdentifier:@"RecipeSearchCell"];
    
    cell.searchLabel.text = self.searches[indexPath.row][@"title"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searches.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    self.recipeField.text = self.searches[indexPath.row][@"title"];
    
    [self.searchTableView setHidden:TRUE];
}

@end
