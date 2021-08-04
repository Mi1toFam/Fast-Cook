//
//  RecipesViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/14/21.
//

#import "RecipesViewController.h"
#import "RecipeCell.h"
#import "Recipe.h"
#import "DetailsViewController.h"
#import "APIManager.h"

@interface RecipesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *recipes;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation RecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchRecipes];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchRecipes) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)fetchRecipes{
    NSString *link = [self retrieveURL];
    [[APIManager shared] getRecipesWithURL:link withCompletion:^(NSArray *recipes, NSError *error) {
        if (recipes) {
            self.recipes = recipes;
            
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        }
        else {
            NSLog(@"😫😫😫 Error getting recipes: %@", error.localizedDescription);
        }
    }];
}

- (NSString *)retrieveURL{
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Info" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    id key = [dict objectForKey: @"API_KEY"];
    NSString *link = @"https://api.spoonacular.com/recipes/complexSearch?number=20&apiKey=";
    link = [link stringByAppendingString:key];
    if (self.titleMatch != nil) {
        NSString *title = [@"&titleMatch=" stringByAppendingString:self.titleMatch];
        link = [link stringByAppendingString:title];
    }
    if ([self.isVegan isEqual:@"vegan"]) {
        link = [link stringByAppendingString:@"&diet=vegan"];
    }
    else if ([self.isVegetarian isEqual:@"vegetarian"]) {
        link = [link stringByAppendingString:@"&diet=vegetarian"];
    }
    if (self.maxReadyTime != nil) {
        NSString *time = [@"&number=50&maxReadyTime=" stringByAppendingString:self.maxReadyTime];
        link = [link stringByAppendingString:time];
    }
    if (self.ingredients != nil) {
        NSString *ingredientsList = @"&includeIngredients=";
        for (NSString *ingredient in self.ingredients) {
            ingredientsList = [ingredientsList stringByAppendingString:ingredient];
            ingredientsList = [ingredientsList stringByAppendingString:@",+"];
        }
        ingredientsList = [ingredientsList substringToIndex:(ingredientsList.length - 2)];
        link = [link stringByAppendingString:ingredientsList];
    }
    return link;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *recipe = self.recipes[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    NSNumber *idNumber = recipe[@"id"];
    detailsViewController.iD = [idNumber stringValue];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecipeCell *cell = nil;
    if (indexPath.row % 2 == 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell"];
    }
    else {
         cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell2"];
    }
    
    cell.circleView.layer.cornerRadius = 20;
    
    cell.recipe = [[Recipe alloc] initWithDictionary:self.recipes[indexPath.row]];
    
    [cell refreshData];
        
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipes.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Define the initial state (Before the animation)
    cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0);
    
    // Define the final state (after the animation)
    [UIView animateWithDuration:1.0 animations:^{cell.layer.transform = CATransform3DIdentity;}];
    
}

@end
