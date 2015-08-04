//
//  DietCalcViewController.h
//  DietCalculator
//
//  Created by wojtek on 03/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produkt.h"
#import "Menu.h"
@interface DietCalcViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableArray *dietProductsArray;
@property (strong, nonatomic) NSMutableArray *productsArray;
@property (strong, nonatomic) NSArray *pobraneDni;
@property (nonatomic, retain) Produkt * detailProdukt;
@property (nonatomic, retain) Menu * menuDnia;
//-(Produkt*)tworzProdukt:(Produkt*) produktWzorzec oWadze:(float) waga;
-(NSString*)aktualizujPodsumowanie;

@end
