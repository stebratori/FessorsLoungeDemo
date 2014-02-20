//
//  EquationDecoder.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "EquationDecoder.h"

@implementation EquationDecoder


// Returns an NSString equation.
// Makes it by randoming two numbers and conducting the input operation to get an input result.

-(NSString*)equationMaker:(int)result forOperation:(int)operation
{
    
    NSString *output= @"Error";
    int value1;
    int value2;
    
    switch (operation) {
            
            // **** PLUS **** //
            ////////////////////
        case 0:
            value1 = 1 + arc4random() % (result-1);
            
            value2 = result - value1 ;
            output = [NSString stringWithFormat:@"%d+%d",value1,value2];
            break;
            
            // **** MINUS **** //
            ////////////////////
        case 1:
            value1 = 1 + arc4random() % (result-1);
            value2 = result + value1 ;
            output = [NSString stringWithFormat:@"%d-%d",value2,value1];
            break;
            
            // **** MULTIPLY **** //
            ///////////////////////
        case 2:
            
            // 2
            if (result == 2){
                int random = 1 + arc4random() % (2-1);
                
                if (random == 2){
                    output = @"2*1";
                }else{
                    output = @"1*2";
                }
                
            }
            
            //3
            if (result == 3){
                int random = 1 + arc4random() % (2-1);
                
                if (random == 2){
                    output = @"3*1";
                }else{
                    output = @"1*3";
                }
                
            }
            
            
            //4
            if (result == 4){
                int random = 1 + arc4random() % (5-1);
                
                if (random == 2){
                    output = @"4*1";
                }
                if(random == 1){
                    output = @"1*4";
                }
                if (random == 3 || random == 4 || random == 5){
                    output = @"2*2";
                }
                
            }
            
            //5
            if (result == 5){
                int random = 1 + arc4random() % (4-1);
                
                if (random == 2){
                    output = @"5*1";
                }else{
                    output = @"1*5";
                }
                
            }
            
            //6
            
            if (result == 6){
                int random = 1 + arc4random() % (8-1);
                
                
                if (random == 1){
                    output = @"3*2";
                }
                if (random == 2){
                    output = @"2*3";
                }
                if (random == 3 || random == 4 || random == 5){
                    output = @"6*1";
                }
                if (random == 6 || random == 7 || random == 8){
                    output = @"1*6";
                }
                
            }
            
            
            
            //7
            if (result == 7){
                int random = 1 + arc4random() % (2-1);
                
                if (random == 2){
                    output = @"7*1";
                }else{
                    output = @"1*7";
                }
                
            }
            
            //8
            if (result == 8){
                int random = 1 + arc4random() % (8-1);
                
                if (random == 1){
                    output = @"8*1";
                }if (random == 2){
                    output = @"1*8";
                }
                if (random == 3 || random == 4 || random == 5){
                    output = @"2*4";
                }if (random == 6 || random == 7 || random == 8){
                    output = @"4*2";
                }
                
            }
            
            //9
            if (result == 9){
                int random = 1 + arc4random() % (5-1);
                
                if (random == 1){
                    output = @"9*1";
                }
                if(random == 2){
                    output = @"1*9";
                }
                if(random == 3 || random == 4 || random == 5){
                    output = @"3*3";
                }
                
            }
            
            //10
            if (result == 10){
                int random = 1 + arc4random() % (2-1);
                
                if (random == 2){
                    output = @"10*1";
                }else{
                    output = @"1*10";
                }
                
            }
            break;
            
            
            // **** DIVIDE **** //
            ///////////////////////
        case 3:
            output = [self divideEquationMaker:result];
            break;
    }
    
    return output;
    
}

//Returns an integer result for a given equation.
//it is not needed to put an operation input parameter, method checks which operation is present on it's own

-(int)equationDecoder:(NSString*)equation
{
    
    int lenght = [equation length];
    unichar firstChar, secondChar, thirdChar,fourthChar,operation;
    NSString *sNumber1, *sNumber2, *sNumber3,*sNumber4,*sOperation;
    
    int number1, number2,number3,number4;
    int result = 0;
    
    // Method checks the type of equation.
    
    switch (lenght) {
            
            // It is a simple a#bequation
        case 3:
            firstChar = [equation characterAtIndex:0];
            operation = [equation characterAtIndex:1];
            secondChar = [equation characterAtIndex:2];
            
            sOperation = [self charToString:operation];
            sNumber1 = [self charToString:firstChar];
            sNumber2 = [self charToString:secondChar];
            
            number1 = [sNumber1 intValue];
            number2 = [sNumber2 intValue];
            
            if ([sOperation isEqualToString:@"+"]){
                result = number1 + number2;
            }
            
            else{
                result = number1 - number2;
            }
            
            
            break;
            
            
            // It's a ab#c  equation
        case 4:
            firstChar = [equation characterAtIndex:0];
            secondChar = [equation characterAtIndex:1];
            operation = [equation characterAtIndex:2];
            thirdChar = [equation characterAtIndex:3];
            
            
            sOperation = [self charToString:operation];
            sNumber1 = [self charToString:firstChar];
            sNumber2 = [self charToString:secondChar];
            sNumber3 = [self charToString:thirdChar];
            
            
            number1 = [sNumber1 intValue];
            number2 = [sNumber2 intValue];
            number3 = [sNumber3 intValue];
            
            
            if ([sOperation isEqualToString:@"+"]){
                result = (number1*10 + number2) + number3;
            }
            
            else{
                result = (number1*10 + number2) - number3;
            }
            
            
            
            break;
            
            
            
            // it's a ab+cd or ab-cd equation
        case 5:
            firstChar = [equation characterAtIndex:0];
            secondChar = [equation characterAtIndex:1];
            operation = [equation characterAtIndex:2];
            thirdChar = [equation characterAtIndex:3];
            fourthChar = [equation characterAtIndex:4];
            
            sOperation = [self charToString:operation];
            sNumber1 = [self charToString:firstChar];
            sNumber2 = [self charToString:secondChar];
            sNumber3 = [self charToString:thirdChar];
            sNumber4 = [self charToString:fourthChar];
            
            number1 = [sNumber1 intValue];
            number2 = [sNumber2 intValue];
            number3 = [sNumber3 intValue];
            number4 = [sNumber4 intValue];
            
            if ([sOperation isEqualToString:@"+"]){
                result = (number1*10 + number2) + (number3*10+number4);
            }
            
            if ([sOperation isEqualToString:@"+"]){
                result = (number1*10 + number2) + (number3*10+number4);
            }
            
            if ([sOperation isEqualToString:@"*"]){
                result = (number1*10 + number2) * (number3*10+number4);
            }
            
            if ([sOperation isEqualToString:@"/"]){
                result = (number1*10 + number2) / (number3*10+number4);
            }
            
            break;
    }
    
    return result;
    
}


// Casts char to String

-(NSString*)charToString:(unichar)utf8char{
    char chars[2];
    int len = 1;
    
    if (utf8char > 127) {
        chars[0] = (utf8char >> 8) & (1 << 8) - 1;
        chars[1] = utf8char & (1 << 8) - 1;
        len = 2;
    } else {
        chars[0] = utf8char;
    }
    
    NSString *string = [[NSString alloc] initWithBytes:chars
                                                length:len
                                              encoding:NSUTF8StringEncoding];
    
    return string;
}


// Returns an array of equations
// Equations are made using equationMaker method
// This method needs two input paramethers - list size (how many equations) and an operation

-(NSMutableArray*)equationListMaker:(int)listSize for:(int)operation{
    
    NSMutableArray* equationsList = [[NSMutableArray alloc]init];
    
    for (int i=2;i<listSize+2;i++){
        [equationsList addObject:[self equationMaker:i forOperation:operation]];
    }
    
    return equationsList;
}

- (NSArray*)shuffleEquationListMaker:(int)operation forSize:(int)size
{
    
    NSMutableArray* equationArray   = [self equationListMaker:size for:operation];
    NSMutableArray* tempArray       = [[NSMutableArray alloc]init];
    
    
    
    while ([equationArray count] > 0) {
        
        NSUInteger randomNum = arc4random() % [equationArray count];
        [tempArray addObject:equationArray[randomNum]];
        [equationArray removeObjectAtIndex:randomNum];
    }
    
    return tempArray;
}

-(NSString*)divideEquationMaker:(int)result
{
    int random = 1 + arc4random() % (9-1);
    NSString *equation = Nil;
    int divValue;
    
    switch (random) {
            
        case 1:
            equation = [NSString stringWithFormat:@"%d:1",result];
            break;
            
        case 2:
            divValue = result * 2;
            equation = [NSString stringWithFormat:@"%d:2",divValue];
            break;
            
        case 3:
            divValue = result * 3;
            equation = [NSString stringWithFormat:@"%d:3",divValue];
            break;
            
        case 4:
            divValue = result * 4;
            equation = [NSString stringWithFormat:@"%d:4",divValue];
            break;
            
        case 5:
            divValue = result * 5;
            equation = [NSString stringWithFormat:@"%d:5",divValue];
            break;
            
        case 6:
            divValue = result * 6;
            equation = [NSString stringWithFormat:@"%d:6",divValue];
            break;
            
        case 7:
            divValue = result * 7;
            equation = [NSString stringWithFormat:@"%d:7",divValue];
            break;
            
        case 8:
            divValue = result * 8;
            equation = [NSString stringWithFormat:@"%d:8",divValue];
            break;
            
        case 9:
            divValue = result * 9;
            equation = [NSString stringWithFormat:@"%d:9",divValue];
            break;
    }
    
    return equation;
}


@end
