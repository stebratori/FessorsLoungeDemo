//
//  EquationDecoder.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquationDecoder : NSObject

-(NSString*)equationMaker:(int)result forOperation:(int)operation;
-(int)equationDecoder:(NSString*)equation;
-(NSString*)charToString:(unichar)utf8char;
-(NSMutableArray*)equationListMaker:(int)listSize for:(int)operation;
-(NSArray*)shuffleEquationListMaker:(int)operation forSize:(int)size;
@end
