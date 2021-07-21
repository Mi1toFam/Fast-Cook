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

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchButton.layer.cornerRadius = 40;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    RecipesViewController *recipesViewController = [segue destinationViewController];
    if ([self.isVegan isOn]) {
        recipesViewController.isVegan = @"vegan";
    }
    else if ([self.isVegetarian isOn]) {
        recipesViewController.isVegetarian = @"vegetarian";
    }
    recipesViewController.maxReadyTime = self.readyField.text;
}


@end
