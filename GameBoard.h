//
//  GameBoard.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameBoard : UIViewController

-(IBAction)startGameBoard:(UIStoryboardSegue *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *gameboard;

@property (weak, nonatomic) IBOutlet UIButton *cloudAnswer1;
@property (weak, nonatomic) IBOutlet UIButton *cloudAnswer2;
@property (weak, nonatomic) IBOutlet UIButton *cloudAnswer3;
@property (weak, nonatomic) IBOutlet UIButton *cloudAnswer4;
@property (strong, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UIButton *cloudQuestion;

@property (weak, nonatomic) IBOutlet UIImageView *gameboardMedal;

@property (weak, nonatomic) IBOutlet UILabel *gameboardCoins;

@property (weak, nonatomic) IBOutlet UIImageView *fessor;

@property int equation;

-(IBAction)generateEquation;

-(IBAction)cloudClick:(UIButton*)sender;

@property UIImage *whiteCloud;
@property UIImage *greenCloud;
@property UIImage *redCloud;

@property UIImage *gold;
@property UIImage *silver;
@property UIImage *bronze;

@property UIImage *iceland;
@property UIImage *faroe;
@property UIImage *norway;
@property UIImage *denmark;
@property UIImage *sweden;
@property UIImage *finland;

@property UIImage *regular;
@property UIImage *hero;
@property UIImage *cowboy;
@property UIImage *indian;
@property UIImage *pirate;
@property UIImage *viking;

@property (strong, nonatomic) IBOutlet UIImageView *theDoors;

@property int points;
@property int medalCounter;
@property int blinkCounter;

@property NSInteger pace;


@end
