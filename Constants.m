//
//  Constants.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static Constants *constants = nil;


+ (Constants*)shared {
    
    if (nil == constants) {
        
        if (constants == nil) {
            constants = [[[self class]alloc] init];
            //constants.coins=0;
        }
        
        
    }
    
    return constants;
}






@end
