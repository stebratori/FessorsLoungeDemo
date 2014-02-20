//
//  NumberGenerator.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "NumberGenerator.h"
#import "EquationDecoder.h"

@implementation NumberGenerator

@synthesize randomNumber,list,randomArray;


-(NSString*)generateRandom:(int)result fromValue:(int)from toValue: (int)to{
    
    randomNumber = from + arc4random() % (to-from);
    while (randomNumber == result) {
        randomNumber = from + arc4random() % (to-from);
    }
    NSString *returnString = [NSString stringWithFormat:@"%d",randomNumber];
    return returnString;
}

-(NSString*)generateRandom:(int)result differentFrom:(int)random1 fromValue:(int)from toValue: (int)to{
    randomNumber = from + arc4random() % (to-from);
    while (randomNumber == result || randomNumber == random1) {
        randomNumber = from + arc4random() % (to-from);
    }
    NSString *returnString = [NSString stringWithFormat:@"%d",randomNumber];
    return returnString;
}

-(NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 fromValue:(int)from toValue: (int)to{
    randomNumber = from + arc4random() % (to-from);
    while (randomNumber == result || randomNumber == random1 || randomNumber == random2) {
        randomNumber = from + arc4random() % (to-from);
    }
    NSString *returnString = [NSString stringWithFormat:@"%d",randomNumber];
    return returnString;
}

-(NSString*)generateRandom:(int)result differentFrom:(int)random1 andDifferentFrom:(int)random2 andDifferentFrom:(int) random3 fromValue:(int)from toValue: (int)to{
    randomNumber = from + arc4random() % (to-from);
    while (randomNumber == result || randomNumber == random1 || randomNumber == random2 || randomNumber == random3) {
        randomNumber = from + arc4random() % (to-from);
    }
    NSString *returnString = [NSString stringWithFormat:@"%d",randomNumber];
    return returnString;
}

/*
 -(NSMutableArray*)populateList:(int) list_size fo{
 
 self.list = [NSMutableArray new];
 
 
 self.randomArray = [NSMutableArray new];
 
 for (int i=2; i<list_size+2; i++) {
 [list addObject:[NSNumber numberWithInt:i]];
 }
 
 
 for (int i=2; i<list_size+2; i++) {
 
 int arrIndex = 0 + arc4random() %([list count] - 0);
 
 NSNumber *randomNo = [list objectAtIndex:arrIndex];
 
 [list removeObjectAtIndex:arrIndex];
 
 [randomArray addObject:randomNo];
 
 }
 
 return list;
 
 }
 */



- (NSArray*)shuffle:(int) list_size
{
    
    NSMutableArray* shuffledArray   = [[NSMutableArray alloc]init];
    NSMutableArray* tempArray       = [[NSMutableArray alloc]init];
    
    for (int i=2; i<list_size+2; i++) {
        
        [shuffledArray addObject:[NSNumber numberWithInt:i]];
    }
    
    while ([shuffledArray count] > 0) {
        
        NSUInteger randomNum = arc4random() % [shuffledArray count];
        [tempArray addObject:shuffledArray[randomNum]];
        [shuffledArray removeObjectAtIndex:randomNum];
    }
    
    return tempArray;
}





-(NSArray*)populateTable:(int)size for:(int)operation
{
    
    EquationDecoder *equationDecoder = [[EquationDecoder alloc]init];
    
    NSArray* numbers = [self shuffle:size/2];
    
    
    NSArray* equations = [equationDecoder shuffleEquationListMaker:operation forSize:size/2];
    
    NSMutableArray *populatedRandomList = [[NSMutableArray alloc]init];
    NSMutableArray *finalArray = [[NSMutableArray alloc]init];
    
    [populatedRandomList addObjectsFromArray:numbers];
    [populatedRandomList addObjectsFromArray:equations];
    
    
    
    while ([populatedRandomList count] > 0) {
        
        NSUInteger randomNum = arc4random() % [populatedRandomList count];
        [finalArray addObject:populatedRandomList[randomNum]];
        [populatedRandomList removeObjectAtIndex:randomNum];
    }
    
    return finalArray;
    
}

@end
