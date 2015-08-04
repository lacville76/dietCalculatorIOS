//
//  Produkt.h
//  DietCalculator
//
//  Created by wojtek on 01/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Menu;

@interface Produkt : NSManagedObject

@property (nonatomic, retain) NSNumber * bialka;
@property (nonatomic, retain) NSNumber * kcal;
@property (nonatomic, retain) NSString * nazwa;
@property (nonatomic, retain) NSNumber * tluszcze;
@property (nonatomic, retain) NSNumber * waga;
@property (nonatomic, retain) NSNumber * wegle;
@property (nonatomic, retain) Menu *dzien;
+(NSArray *)pobierzWszystkieProdukty;
+(void)dodajProdukt:(NSString *)sName zBialkiem:(NSNumber *) sbialko zWeglowodanami:(NSNumber *)  swegle zKcal: (NSNumber *)  kcal zTluszczami:(NSNumber *) tluszcze;
+(void)usunWszystkieProdukty;
+(NSMutableArray *)pobierzWzorce;
+(Produkt*)tworzProdukt:(Produkt*) produktWzorzec oWadze:(float) waga;
+(void)TworzListeProduktow;
@end
