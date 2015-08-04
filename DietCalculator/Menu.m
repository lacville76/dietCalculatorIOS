//
//  Menu.m
//  DietCalculator
//
//  Created by wojtek on 01/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import "Menu.h"
#import "Produkt.h"
#import "AppDelegate.h"


@implementation Menu

@dynamic dzien;
@dynamic posiada;
- (void)addPosiadaObject:(Produkt *)value
{
    
}

+(NSArray *)pobierzDzien:(NSString*) nazwa
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Menu" inManagedObjectContext: moc];
    [fetchRequest setEntity:entity];
//    [fetchRequest setReturnsObjectsAsFaults:FALSE];
    NSPredicate *wzorzecPredicate = [NSPredicate predicateWithFormat:@"dzien contains[cd] %@",nazwa];
     
    [fetchRequest setPredicate:wzorzecPredicate];
//    NSLog(@"%@",nazwa);
    NSError *error;
    NSArray  *dzien =[moc executeFetchRequest:fetchRequest error:&error] ;
    
    return dzien;
}
+(void)dodajDzien:(NSString *)sName
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    
    Menu *menu = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:moc];
    menu.dzien = sName;
    
    
    NSError *error;
    
    if(![moc save:&error])
    {
        NSLog(@"Wystąpił błąd podczas zapisu danych");
    }
    
}
-(void)dodajdoSpisu:(Produkt *)value wDniu: (Menu*)dzien
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
      Produkt *ProduktDieta = [NSEntityDescription insertNewObjectForEntityForName:@"Produkt" inManagedObjectContext:moc];
    ProduktDieta=value;
    [dzien.posiada addObject:ProduktDieta];
    ProduktDieta.dzien=dzien;
    NSError *error;
    
    if(![moc save:&error])
    {
        NSLog(@"Wystąpił błąd podczas zapisu danych");
    }
}

@end
