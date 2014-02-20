//
//  NumberGenerator.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberGenerator : NSObject


@property (nonatomic,assign) int randomNumber;

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSMutableArray *randomArray;

- (NSString*)generateRandom:(int)result fromValue:(int)from toValue: (int)to;
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 fromValue:(int)from toValue: (int)to;
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 fromValue:(int)from toValue: (int)to;
-(NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 andDifferentFrom:(int) random3 fromValue:(int)from toValue: (int)to;

- (NSArray*)populateTable:(int)size for:(int)operation;
- (NSArray*)shuffle:(int) list_size;


@end
