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
    NSString *link = @"https://api.spoonacular.com/recipes/complexSearch?apiKey=68c1462cdfc64471a3c2df51555225be&number=50";
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
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               
               UIAlertController *alert = [UIAlertController
                                           alertControllerWithTitle:@"Cannot Retrieve Recipes"
                                           message:@""
                                           preferredStyle:(UIAlertControllerStyleAlert)];
               
               UIAlertAction *okAction = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * _Nonnull action) {}];
               // add the OK action to the alert controller
               [alert addAction:okAction];
              
               [self presentViewController:alert animated:YES completion:^{
                   // optional code for what happens after the alert controller has finished presenting
               }];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                             
               self.recipes = dataDictionary[@"results"];
               
               [self.tableView reloadData];
               
               [self.refreshControl endRefreshing];
           }
    }];
    [task resume];
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
        
    cell.recipe = [[Recipe alloc] initWithDictionary:self.recipes[indexPath.row]];
    
    cell.contentView.layer.cornerRadius = 40;
    cell.contentView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner | kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [cell.contentView sizeToFit];
    
    [cell refreshData];
        
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipes.count;
}

@end
