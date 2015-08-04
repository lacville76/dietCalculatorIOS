//
//  Produkt.m
//  DietCalculator
//
//  Created by wojtek on 01/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import "Produkt.h"
#import "Menu.h"
#import "AppDelegate.h"


@implementation Produkt

@dynamic bialka;
@dynamic kcal;
@dynamic nazwa;
@dynamic tluszcze;
@dynamic waga;
@dynamic wegle;
@dynamic dzien;
+(NSArray *)pobierzWszystkieProdukty
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Produkt" inManagedObjectContext: moc];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *products = [moc executeFetchRequest:fetchRequest error:&error];
    
    return products;
}
+(void)dodajProdukt:(NSString *)sName zBialkiem:(NSNumber *) sbialko zWeglowodanami:(NSNumber *)  swegle zKcal: (NSNumber *)  kcal zTluszczami:(NSNumber *) tluszcze
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    
    Produkt *produkt = [NSEntityDescription insertNewObjectForEntityForName:@"Produkt" inManagedObjectContext:moc];
    produkt.nazwa = sName;
    produkt.bialka = sbialko;
    produkt.wegle=swegle;
    produkt.kcal=kcal;
    produkt.tluszcze=tluszcze;
    
    
    NSError *error;
    
    if(![moc save:&error])
    {
        NSLog(@"Wystąpił błąd podczas zapisu danych");
    }
    
}
+(void)usunWszystkieProdukty
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Produkt" inManagedObjectContext: moc];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *products = [moc executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject * car in products) {
        [moc deleteObject:car];
    }
if(![moc save:&error])
{
    NSLog(@"Wystąpił błąd podczas zapisu danych");
}
}
+(NSMutableArray *)pobierzWzorce
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Produkt" inManagedObjectContext: moc];
  

    NSPredicate *wzorzecPredicate = [NSPredicate predicateWithFormat:@"waga=0"];
    [fetchRequest setPredicate:wzorzecPredicate];
     NSError *error;
   [fetchRequest setEntity:entity];
    NSArray  *products1 = [moc executeFetchRequest:fetchRequest error:&error] ;
      
   
    NSMutableArray  *products = [products1 mutableCopy];

    [products filterUsingPredicate:[NSPredicate predicateWithFormat:@"nazwa!=nil"]];

    return products;
}
+(Produkt*)tworzProdukt:(Produkt*) produktWzorzec oWadze:(float) waga
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    
    Produkt *ProduktDieta = [NSEntityDescription insertNewObjectForEntityForName:@"Produkt" inManagedObjectContext:moc];
    ProduktDieta.nazwa=produktWzorzec.nazwa;
    ProduktDieta.wegle=[NSNumber numberWithFloat:([produktWzorzec.wegle floatValue]*waga)/100];
    ProduktDieta.bialka=[NSNumber numberWithFloat:([produktWzorzec.bialka floatValue]*waga)/100];
    ProduktDieta.kcal=[NSNumber numberWithFloat:([produktWzorzec.kcal floatValue]*waga)/100];
    ProduktDieta.tluszcze=[NSNumber numberWithFloat:([produktWzorzec.tluszcze floatValue]*waga)/100];
    ProduktDieta.waga=[NSNumber numberWithFloat:([produktWzorzec.waga floatValue]*waga)/100];
    ProduktDieta.waga=[NSNumber numberWithFloat:waga];
    return ProduktDieta;
    
}
+(void)TworzListeProduktow
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    NSArray* produkty = [self.class pobierzWzorce];
    if([produkty count] ==0){
    [self.class dodajProdukt:@"Agrest" zBialkiem:[NSNumber numberWithFloat:0.80] zWeglowodanami:[NSNumber numberWithFloat: 8.8] zKcal:[NSNumber numberWithFloat: 44.0] zTluszczami:[NSNumber numberWithFloat:0.15]];
    [self.class dodajProdukt:@"Algi Morskie" zBialkiem:[NSNumber numberWithFloat:60.00] zWeglowodanami:[NSNumber numberWithFloat: 14.50] zKcal:[NSNumber numberWithFloat: 360.00] zTluszczami:[NSNumber numberWithFloat:7.00]];
    [self.class dodajProdukt:@"Ananas" zBialkiem:[NSNumber numberWithFloat:0.4] zWeglowodanami:[NSNumber numberWithFloat: 13.6] zKcal:[NSNumber numberWithFloat: 54.0] zTluszczami:[NSNumber numberWithFloat:0.20]];
    [self.class dodajProdukt:@"Bagietka" zBialkiem:[NSNumber numberWithFloat:6.00] zWeglowodanami:[NSNumber numberWithFloat: 45.7] zKcal:[NSNumber numberWithFloat: 217.00] zTluszczami:[NSNumber numberWithFloat:0.8]];
    [self.class dodajProdukt:@"Chleb" zBialkiem:[NSNumber numberWithFloat:6.15] zWeglowodanami:[NSNumber numberWithFloat: 1.2] zKcal:[NSNumber numberWithFloat: 238.00] zTluszczami:[NSNumber numberWithFloat:1.2]];
    [self.class dodajProdukt:@"Big Mac" zBialkiem:[NSNumber numberWithFloat:27.00] zWeglowodanami:[NSNumber numberWithFloat: 40.00] zKcal:[NSNumber numberWithFloat: 495.00] zTluszczami:[NSNumber numberWithFloat:25.00]];
    [self.class dodajProdukt:@"Cappucino" zBialkiem:[NSNumber numberWithFloat:10.17] zWeglowodanami:[NSNumber numberWithFloat: 42.48] zKcal:[NSNumber numberWithFloat: 344.95] zTluszczami:[NSNumber numberWithFloat:15.06]];
    [self.class dodajProdukt:@"Bigos" zBialkiem:[NSNumber numberWithFloat:4.47] zWeglowodanami:[NSNumber numberWithFloat: 1.8] zKcal:[NSNumber numberWithFloat: 40.75] zTluszczami:[NSNumber numberWithFloat:1.37]];
    [self.class dodajProdukt:@"Bake Rolls" zBialkiem:[NSNumber numberWithFloat:13.00] zWeglowodanami:[NSNumber numberWithFloat: 61.00] zKcal:[NSNumber numberWithFloat: 461.0] zTluszczami:[NSNumber numberWithFloat:17.00]];
    [self.class dodajProdukt:@"Bazylia" zBialkiem:[NSNumber numberWithFloat:14.30] zWeglowodanami:[NSNumber numberWithFloat: 61.00] zKcal:[NSNumber numberWithFloat:251.00] zTluszczami:[NSNumber numberWithFloat:4.00]];
    [self.class dodajProdukt:@"Baton" zBialkiem:[NSNumber numberWithFloat:4.80] zWeglowodanami:[NSNumber numberWithFloat: 60.50] zKcal:[NSNumber numberWithFloat: 485.00] zTluszczami:[NSNumber numberWithFloat:26.00]];
    [self.class dodajProdukt:@"Musli" zBialkiem:[NSNumber numberWithFloat:5.66] zWeglowodanami:[NSNumber numberWithFloat: 36.78] zKcal:[NSNumber numberWithFloat: 207.63] zTluszczami:[NSNumber numberWithFloat:3.23]];
    }
    NSError *error;
    
    if(![moc save:&error])
    {
        NSLog(@"Wystąpił błąd podczas zapisu danych");
    }
    
}

@end
