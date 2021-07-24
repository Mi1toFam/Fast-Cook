//
//  SearchViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/13/21.
//

#import "SearchViewController.h"
#import "RecipesViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *readyField;
@property (weak, nonatomic) IBOutlet UISwitch *isVegetarian;
@property (weak, nonatomic) IBOutlet UISwitch *isVegan;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *recipeSearchButton;
@property (weak, nonatomic) IBOutlet UITextField *recipeField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchButton.layer.cornerRadius = 25;
    self.recipeSearchButton.layer.cornerRadius = 30;
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
    }
    else {
        RecipesViewController *recipesViewController = [segue destinationViewController];
        
        recipesViewController.titleMatch = self.recipeField.text;
    }
}


@end
