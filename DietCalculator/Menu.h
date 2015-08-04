//
//  Menu.h
//  DietCalculator
//
//  Created by wojtek on 01/06/2014.
//  Copyright (c) 2014 wojtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Produkt;

@interface Menu : NSManagedObject

@property (nonatomic, retain) NSString * dzien;
@property (nonatomic, retain) NSMutableSet *posiada;
@end

@interface Menu (CoreDataGeneratedAccessors)

- (void)addPosiadaObject:(Produkt *)value;
- (void)removePosiadaObject:(Produkt *)value;
- (void)addPosiada:(NSSet *)values;
- (void)removePosiada:(NSSet *)values;
+(void)dodajDzien:(NSString *)sName;
-(void)dodajdoSpisu:(Produkt *)value wDniu: (Menu*)dzien;
+(NSArray *)pobierzDzien:(NSString*) nazwa;
@end
