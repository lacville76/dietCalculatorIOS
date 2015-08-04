//
//  DetailViewController.h
//  DietCalculator
//
//  Created by wojtek on 14/05/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSArray *productsArray;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
