//
//  DetailViewController.m
//  DietCalculator
//
//  Created by wojtek on 14/05/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import "DetailViewController.h"
#import "Produkt.h"
#import "Menu.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabelaProdukty;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPickerView *ProducPicker;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"dzien"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabelaProdukty.dataSource=self;
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    NSNumber *nr = [NSNumber numberWithInt:30];
   // [Produkt dodajProdukt:@"ser" zBialkiem:nr zWeglowodanami:nr zKcal:nr zTluszczami:nr];
  //   [Produkt dodajProdukt:@"ser" zBialkiem:nr zWeglowodanami:nr zKcal:nr zTluszczami:nr];
    self.productsArray = [Produkt pobierzWszystkieProdukty];
    //[Produkt usunWszystkieProdukty];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tabelaProdukty numberOfRowsInSection:(NSInteger)section {
 return [self.productsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tabelaProdukty cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellIdentifier = @"Cell";
  
    UITableViewCell *cell = [tabelaProdukty dequeueReusableCellWithIdentifier:cellIdentifier];
    

    if (cell == nil)
       {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
      }
    

    Produkt *tweet = [self.productsArray objectAtIndex:indexPath.row];
    //7
 
      [cell.textLabel setText:tweet.nazwa];
    [cell.detailTextLabel setText:@"via Codigator"];
    return cell;
}
@end
