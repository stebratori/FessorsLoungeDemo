//
//  Controller.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberGenerator.h"
#import "EquationDecoder.h"

@interface Controller : NSObject

+ (Controller*)shared;

@property NumberGenerator *numberGenerator;
@property EquationDecoder *equationDecoder;

- (NSString*)generateRandom:(int)result fromValue:(int)from toValue: (int)to;
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 fromValue:(int)from toValue: (int)to;
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 fromValue:(int)from toValue: (int)to;
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 andDifferentFrom:(int) random3 fromValue:(int)from toValue: (int)to;
- (NSString*)equationMaker:(int)result forOperation:(int)operation;
- (int)equationDecoder:(NSString*)equation;
- (NSArray*)populateTable:(int)size for:(int)operation;
- (NSArray*)shuffle:(int) list_size;

@end
