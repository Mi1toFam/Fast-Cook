//
//  IngredientsViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/27/21.
//

#import "IngredientsViewController.h"
#import "SearchViewController.h"
#import "APIManager.h"
#import "RecipeSearchCell.h"
#import "IngredientCell.h"

@interface IngredientsViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UITableView *ingredientsTableView;
@property (strong, nonatomic) NSArray *searches;
@property (strong, nonatomic) NSIndexPath *selectedPath;
@end

@implementation IngredientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.searchTableView setHidden:TRUE];
    
    self.navigationController.delegate = self;
        
    if (self.ingredients == nil) {
        self.ingredients = [[NSMutableArray alloc] init];
    }
    
    else {
        [self.ingredientsTableView reloadData];
    }
    
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    self.ingredientsTableView.delegate = self;
    self.ingredientsTableView.dataSource = self;
        
    [self.searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidChange :(UITextField *) textField{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performAutocomplete) object:nil];
    [self performSelector:@selector(performAutocomplete) withObject:nil afterDelay:0.3];
}

-(void)performAutocomplete {
    if (self.searchField.text.length == 0) {
        [self.searchTableView setHidden:TRUE];
    }
    else {
        [self.searchTableView setHidden:FALSE];
        NSString *link = [@"https://api.spoonacular.com/food/ingredients/autocomplete?apiKey=68c1462cdfc64471a3c2df51555225be&number=10&query=" stringByAppendingString:self.searchField.text];
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

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    searchViewController = (SearchViewController *) viewController;
    searchViewController.ingredients = self.ingredients;
    [searchViewController viewDidLoad];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (tableView == self.searchTableView)
    {
        RecipeSearchCell *cell = [self.searchTableView dequeueReusableCellWithIdentifier:@"RecipeSearchCell"];
        
        cell.searchLabel.text = self.searches[indexPath.row][@"name"];
        
        return cell;
    }
    else {
        IngredientCell *cell = [self.ingredientsTableView dequeueReusableCellWithIdentifier:@"IngredientCell"];
        
        cell.nameLabel.text = self.ingredients[indexPath.row];
        cell.indexPath = indexPath;
        cell.delegate = self;
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchTableView){
        return self.searches.count;
    }
    else {
        return self.ingredients.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchTableView) {
        [self.ingredients addObject:self.searches[indexPath.row][@"name"]];
                
        self.searchField.text = @"";

        [self.searchTableView setHidden:TRUE];

        [self.ingredientsTableView reloadData];
    }
}

- (void)removeTableViewCellAtPath: (NSIndexPath *)indexPath {
    [self.ingredients removeObjectAtIndex:(NSUInteger)indexPath.row];
    
    NSMutableArray *indexPaths  = [[NSMutableArray alloc] init];
    [indexPaths addObject:indexPath];
    
    [self.ingredientsTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
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
