//
//  ProduktManageViewController.m
//  DietCalculator
//
//  Created by wojtek on 02/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import "ProduktManageViewController.h"
#import "Produkt.h"
#import "AppDelegate.h"
@interface ProduktManageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *produktTable;
@property (weak, nonatomic) IBOutlet UITextField *NazwaTxt;
@property (weak, nonatomic) IBOutlet UITextField *KCalTxt;
@property (weak, nonatomic) IBOutlet UITextField *WeglowodanyTxt;
@property (weak, nonatomic) IBOutlet UITextField *BialkoTxt;
@property (weak, nonatomic) IBOutlet UITextField *Tluszcze;


@end

@implementation ProduktManageViewController
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (IBAction)powrot:(UITextField* )sender {
    [sender resignFirstResponder];
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
- (IBAction)DodajProdukt:(id)sender
{
  if([self.NazwaTxt.text length]!=0 && [self.Tluszcze.text length]!=0 && [self.WeglowodanyTxt.text length]!=0 && [self.BialkoTxt.text length]!=0 && [self.KCalTxt.text length]!=0)
   {  [_produktTable beginUpdates];
    [Produkt dodajProdukt:_NazwaTxt.text zBialkiem:[NSNumber numberWithFloat:[_BialkoTxt.text floatValue]] zWeglowodanami:[NSNumber numberWithFloat:[_WeglowodanyTxt.text floatValue]]  zKcal:[NSNumber numberWithFloat:[_KCalTxt.text floatValue]]  zTluszczami:[NSNumber numberWithFloat:[_Tluszcze.text floatValue]] ];
 self.productsArray = [Produkt pobierzWzorce];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.productsArray count]-1 inSection:0]];
    [self.produktTable insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];

    [_produktTable endUpdates];
       [_produktTable reloadData];
    [self.produktTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.productsArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
   }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Przeliczenie" message:@"Uzupelnij wymagane pola" delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;

    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     self.productsArray = [Produkt pobierzWzorce];
    //  self.view.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:243.0f/255.0f blue:255.0f/255.0f alpha:1.0f];

    [Produkt TworzListeProduktow];
    [self.produktTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tabelaProdukty numberOfRowsInSection:(NSInteger)section {
    return [self.productsArray count];
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
-(UITableViewCell *)tableView:(UITableView *)tabelaProdukty cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //5
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tabelaProdukty dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    Produkt *tweet = [self.productsArray objectAtIndex:indexPath.row];
    //7
   
    [cell.textLabel setText:tweet.nazwa];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"B:%@ T:%@ W:%@ Kcal:%@",[tweet.bialka stringValue],[tweet.tluszcze stringValue],[tweet.wegle stringValue] ,[tweet.kcal stringValue] ]];
    return cell;
    
}




- (void) animateTextField: (UITextField*) bialkoTxt up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.produktTable beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.view setNeedsDisplay];
    
    [self.produktTable reloadData];
    [self.produktTable endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  //  NSManagedObject *object = [self.productsArray objectAtIndex:indexPath.row];
   // cell.textLabel.text = [[object valueForKey:@"nazwa"] description];
}

- (void)tableView:(UITableView *)produktTable commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [produktTable beginUpdates];
       AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.productsArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.productsArray removeObjectAtIndex:indexPath.row];
        [self.produktTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
       
       
    }
 [produktTable endUpdates];

}



@end
