//
//  Controller.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "Controller.h"

@implementation Controller

static Controller *controller = nil;


+ (Controller*)shared {
    
    if (nil == controller) {
        
        if (controller == nil) {
            controller = [[[self class]alloc] init];
        }
        
    }

    return controller;
}

-(id)init
{
    self = [super init];
    if (self){
        _numberGenerator = [[NumberGenerator alloc]init];
        _equationDecoder = [[EquationDecoder alloc]init];
    }
    return self;
}


- (NSString*)generateRandom:(int)result fromValue:(int)from toValue: (int)to
{
    return [_numberGenerator generateRandom:result fromValue:from toValue:to];
}
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 fromValue:(int)from toValue: (int)to
{
    return [_numberGenerator generateRandom:result differentFrom:random1 fromValue:from toValue:to];
}
- (NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 fromValue:(int)from toValue: (int)to
{
    return [_numberGenerator generateRandom:result differentFrom:random1 andDifferentFrom:random2 fromValue:from toValue:to];
}
-(NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 andDifferentFrom:(int) random3 fromValue:(int)from toValue: (int)to
{
    return [_numberGenerator generateRandom:result differentFrom:random1 andDifferentFrom:random2 andDifferentFrom:random3 fromValue:from toValue:to];
}
-(NSString*)equationMaker:(int)result forOperation:(int)operation
{
    return [_equationDecoder equationMaker:result forOperation:operation];
}

-(int)equationDecoder:(NSString*)equation
{
    return [_equationDecoder equationDecoder:equation];
}
- (NSArray*)populateTable:(int)size for:(int)operation
{
    return [_numberGenerator populateTable:size for:operation];
}

- (NSArray*)shuffle:(int) list_size
{
    return [_numberGenerator shuffle:list_size];
}



@end
