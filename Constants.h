//
//  Constants.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject


typedef enum {
    PLUS,
    MINUS,
    MULTIPLY,
    DIVIDE
} Operation;



typedef enum{
    FESSOR,
    HERO,
    COWBOY,
    INDIAN,
    PIRATE,
    VIKING
}fessorCostume;


@property NSMutableArray *playersArray;

@property int presentOperation;
@property int coins;
@property int memoryBonus;
@property int presentFessorCostume;

@property int lastGameScore;

@property BOOL costumeFessor;
@property BOOL costumeHero;
@property BOOL costumeCowboy;
@property BOOL costumeIndian;
@property BOOL costumePirate;
@property BOOL costumeViking;

@property int previousPlayedGame;



// nscoding
//@property Player* presentPlayer;
@property int presentPlayerIndex;



+ (Constants*)shared;



@end
