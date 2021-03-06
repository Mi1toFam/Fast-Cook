//
//  IngredientCell.h
//  Fast Cook
//
//  Created by Milto Geleta on 7/27/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellCalssDelegate <NSObject>

- (void)removeTableViewCellAtPath:(NSIndexPath *)indexPath;

@end

@interface IngredientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
