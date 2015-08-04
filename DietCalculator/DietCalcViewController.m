//
//  DietCalcViewController.m
//  DietCalculator
//
//  Created by wojtek on 03/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import "DietCalcViewController.h"
#import "Produkt.h"
#import "Menu.h"
#import "AppDelegate.h"
@interface DietCalcViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabelName;
@property (weak, nonatomic) IBOutlet UITextField *txtWaga;
@property (weak, nonatomic) IBOutlet UILabel *podsumowanie;

@end

@implementation DietCalcViewController

@synthesize tableView;
@synthesize picker;
@synthesize productsArray;
@synthesize detailProdukt;
@synthesize menuDnia;
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   self.productsArray = [Produkt pobierzWzorce];
   detailProdukt.nazwa=@"Wybierz Produkt";
    detailProdukt.tluszcze=[NSNumber numberWithInt:0];
    detailProdukt.waga=[NSNumber numberWithInt:0];
     detailProdukt.kcal=[NSNumber numberWithInt:0];
     detailProdukt.bialka=[NSNumber numberWithInt:0];
        detailProdukt.wegle=[NSNumber numberWithInt:0];
 
_dietProductsArray= [NSMutableArray arrayWithArray:[menuDnia.posiada allObjects]];
  self.podsumowanie.text=self.aktualizujPodsumowanie;
   // self.view.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:243.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
     
        self.pobraneDni=[Menu pobierzDzien: [[self.detailItem valueForKey:@"dzien"] description]];
            menuDnia=[self.pobraneDni objectAtIndex:0];
        // Update the view.
        self.navigationItem.backBarButtonItem.title=@"Cofnij";
        [self configureView];

        
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.navigationItem.title= [[self.menuDnia valueForKey:@"dzien"] description];
        
        
    
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)zamknij:(id)sender {
     [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dietProductsArray count] +3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row== [self.dietProductsArray count] )
    {
        UITableViewCell   *cell= [tableView dequeueReusableCellWithIdentifier:@"spaceCell" forIndexPath:indexPath];
      
        cell.backgroundColor=[UIColor colorWithRed:0.6 green:0.8 blue:0.1 alpha:1];
        return  cell;
    }
   
    if(indexPath.row== [self.dietProductsArray count]+1 ){ UITableViewCell   *cell= [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    [picker setDelegate:self];
    
  self.productsArray = [Produkt pobierzWzorce];
 
        picker.showsSelectionIndicator=YES;
    [cell addSubview:picker];
    return cell;
    }
    if(indexPath.row== [self.dietProductsArray count] +2){ UITableViewCell   *cell= [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
        if(detailProdukt!=NULL)
        {
            [cell.textLabel setText:detailProdukt.nazwa];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"B:%1.2f T:%1.2f W:%1.2f Kcal:%1.2f",[detailProdukt.bialka floatValue],[detailProdukt.tluszcze floatValue],[detailProdukt.wegle floatValue] ,[detailProdukt.kcal floatValue]]];
        }
        return  cell;
    }
    else
    {
        UITableViewCell   *cell1= [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
          Produkt *tweet = [self.dietProductsArray objectAtIndex:indexPath.row];
        
      
     [cell1.textLabel setText:tweet.nazwa];
      [cell1.detailTextLabel setText:[NSString stringWithFormat:@"B:%1.2f T:%1.2f W:%1.2f Kcal:%1.2f Waga:%1.2f",[tweet.bialka floatValue],[tweet.tluszcze floatValue],[tweet.wegle floatValue] ,[tweet.kcal floatValue] ,[tweet.waga floatValue]]];
          [cell1.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        return cell1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.row==[self.dietProductsArray count]+1)return 180;
         if(indexPath.row==[self.dietProductsArray count])return 40;
    else return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40; 
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [productsArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  Produkt* produkt=[productsArray objectAtIndex:row];
    return produkt.nazwa;
}
- (IBAction)dodajButton:(id)sender {
 
   menuDnia=(Menu*)_detailItem;
  if([_txtWaga.text length]==0)
 {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Powiadomienie" message:@"Wpisz Wage" delegate:self cancelButtonTitle:@"OK"
       otherButtonTitles:nil];
      [alert show];
      return;

 }
        if(detailProdukt==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Powiadomienie" message:@"Wybierz produkt do dodania" delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
     [tableView beginUpdates];
    Produkt *produkt=[Produkt tworzProdukt:detailProdukt oWadze:[_txtWaga.text floatValue]];
    [menuDnia  dodajdoSpisu:produkt wDniu:menuDnia];
    self.dietProductsArray = [NSMutableArray arrayWithArray:[menuDnia.posiada allObjects]];
     
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.dietProductsArray count]-1 inSection:0]];
 
    

    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
 [tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
     self.podsumowanie.text=self.aktualizujPodsumowanie;
//    [tableView reloadData];
    [tableView endUpdates];
  
     [self.view setNeedsDisplay];
    NSMutableArray* path=[[tableView indexPathsForVisibleRows]mutableCopy];
    [path removeLastObject];
     [path removeLastObject];
     [tableView reloadRowsAtIndexPaths:path withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [tableView beginUpdates];
  
 detailProdukt=[productsArray objectAtIndex:row];
   
    
    
    
    NSArray *paths= [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[self.dietProductsArray count] +2 inSection:0],NULL];
    [tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
      
    [self.tableView reloadData];
    [tableView endUpdates];
      

    
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;
//{
    
//}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{

    
    }
-(IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
- (IBAction)wagaAlert:(id)sender {
  float waga =[self.txtWaga.text floatValue];
    
    NSString* nazwa=detailProdukt.nazwa;
    NSNumber* wegle=[NSNumber numberWithFloat:([detailProdukt.wegle floatValue]*waga)/100];
    NSNumber* bialka=[NSNumber numberWithFloat:([detailProdukt .bialka floatValue]*waga)/100];
    NSNumber* kcal=[NSNumber numberWithFloat:([detailProdukt .kcal floatValue]*waga)/100];
    NSNumber* tluszcze=[NSNumber numberWithFloat:([detailProdukt .tluszcze floatValue]*waga)/100];
  
    NSString* napis;
    napis= [NSString stringWithFormat:@"Bialka:%1.2f Tluszcze:%1.2f Wegle:%1.2f KCal:%1.2f", [bialka floatValue], [tluszcze floatValue], [wegle floatValue],[kcal floatValue]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Przeliczenie" message:napis delegate:self cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    return;

}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
    
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)tableView:(UITableView *)produktTable commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [produktTable beginUpdates];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.dietProductsArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
    
        [self.dietProductsArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
        
    }
    [produktTable endUpdates];
    self.podsumowanie.text=self.aktualizujPodsumowanie;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row== [self.dietProductsArray count] +1) return FALSE;
     if(indexPath.row== [self.dietProductsArray count] +2) return FALSE;
     if(indexPath.row== [self.dietProductsArray count] ) return FALSE;
     else return TRUE;
}

-(NSString*)aktualizujPodsumowanie
{
    [tableView beginUpdates];
    float sumaWegle = 0.0;
    float sumaTluszcze= 0.0;;
    float sumaBialka= 0.0;;
    float sumaKCal= 0.0;;
    Produkt* pr;
    for(int i=0;i<[self.dietProductsArray count] ;i++)
    {
        pr=[self.dietProductsArray objectAtIndex:i];
        sumaWegle+=[pr.wegle floatValue];
        sumaTluszcze+=[pr.tluszcze floatValue];
        sumaBialka+=[pr.bialka floatValue];
        sumaKCal+=[pr.kcal floatValue];
    }
    NSString* napis;
  napis= [NSString stringWithFormat:@"Bialka:%1.2f Tluszcze:%1.2f Wegle:%1.2f KCal:%1.2f",sumaBialka,sumaTluszcze,sumaWegle,sumaKCal];
    [self.podsumowanie setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [tableView endUpdates];
    [self.view setNeedsDisplay];
    return napis;
}
@end
