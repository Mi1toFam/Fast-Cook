//
//  DetailsViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/15/21.
//

#import "DetailsViewController.h"
#import "UserRecipe.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (strong, nonatomic) NSDictionary *recipe;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *detailsScrollView;


@end

@implementation DetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addButton.layer.cornerRadius = 40;
    
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
    [query whereKey:@"author" equalTo: user];
    [query whereKey:@"recipeID" equalTo: self.iD];
    query.limit = 1;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
        if (recipes.count == 0) {
            self.addButton.backgroundColor = [UIColor blueColor];
            [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        } else {
            self.addButton.backgroundColor = [UIColor redColor];
            [self.addButton setTitle:@"Remove" forState:UIControlStateNormal];
        }
    }];
            
    [self fetchRecipe];
}

- (void)viewDidLayoutSubviews {
    UIView *contentView;
    
    [self.detailsScrollView addSubview:contentView];
    
    self.detailsScrollView.contentSize = contentView.frame.size; //sets ScrollView content size
}

-(void)fetchRecipe {
    NSString *startURL = @"https://api.spoonacular.com/recipes/";
    NSString *middleURL = [startURL stringByAppendingString:self.iD];
    NSString *fullURL = [middleURL stringByAppendingString:@"/information?apiKey=68c1462cdfc64471a3c2df51555225be"];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               
               UIAlertController *alert = [UIAlertController
                                           alertControllerWithTitle:@"Cannot Retrieve Movies"
                                           message:@"Your internet connection appears to be offline."
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
                              
               self.recipe = dataDictionary;
               
               self.nameLabel.text = dataDictionary[@"title"];
               
               NSNumber *timeData = dataDictionary[@"readyInMinutes"];
               NSString *time = [[timeData stringValue] stringByAppendingString:@" minutes"];
               self.timeLabel.text = time;
               
               NSNumber *servingsData = dataDictionary[@"servings"];
               NSString *servings = [@"Servings: " stringByAppendingString:[servingsData stringValue]];
               self.servingsLabel.text = servings;
               
               NSURL *posterURL = [NSURL URLWithString:dataDictionary[@"image"]];
               self.posterView.image = nil;
               [self.posterView setImageWithURL:posterURL];
               
               NSString *ingredients = @"Ingredients: \n\n";
               for (NSDictionary *ingrArray in dataDictionary[@"extendedIngredients"]) {
                   NSString *ingrName = ingrArray[@"original"];
                   NSString *fullIngr = [ingrName stringByAppendingString:@"\n"];
                   ingredients = [ingredients stringByAppendingString:fullIngr];
               }
               self.ingredientsLabel.text = ingredients;
           }
    }];
    [task resume];
}

- (IBAction)didTapAdd:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
    [query whereKey:@"author" equalTo: [PFUser currentUser]];
    [query whereKey:@"recipeID" equalTo: self.iD];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
        if (recipes.count != 0) {
            for (PFObject *object in recipes) {
                [object deleteInBackground];
            }
            
            self.addButton.backgroundColor = [UIColor blueColor];
            [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        } else {
            [UserRecipe postRecipeWithImage:self.recipe[@"image"] withName:self.nameLabel.text withTime:self.timeLabel.text withID:self.iD];
            
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
