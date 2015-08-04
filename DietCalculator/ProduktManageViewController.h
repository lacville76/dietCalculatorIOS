//
//  ProduktManageViewController.h
//  DietCalculator
//
//  Created by wojtek on 02/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produkt.h"
@interface ProduktManageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *productsArray;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (void) animateTextField: (UITextField*) NazwaTxt up: (BOOL) up;
@end
