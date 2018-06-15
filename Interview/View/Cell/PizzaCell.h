//
//  PizzaCell.h
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PizzaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pizzaImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *pizzaDescription;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
