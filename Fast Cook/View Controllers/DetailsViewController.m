//
//  DetailsViewController.m
//  Fast Cook
//
//  Created by Milto Geleta on 7/15/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (strong, nonatomic) NSDictionary *recipe;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addButton.layer.cornerRadius = 40;
    
    [self fetchRecipes];
}

-(void)fetchRecipes {
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
