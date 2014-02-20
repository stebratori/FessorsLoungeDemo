//
//  SkyFall.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkyFall : UIViewController

-(IBAction)startSkyfall:(UIStoryboardSegue *)sender;

@property (strong, nonatomic) IBOutlet UILabel *coins;

@property (strong, nonatomic) IBOutlet UIButton *cloud1;
@property (strong, nonatomic) IBOutlet UIButton *cloud2;
@property (strong, nonatomic) IBOutlet UIButton *cloud3;
@property (strong, nonatomic) IBOutlet UIButton *cloud4;
@property (strong, nonatomic) IBOutlet UIButton *cloud5;
@property (strong, nonatomic) IBOutlet UIButton *cloud6;
@property (strong, nonatomic) IBOutlet UIButton *cloud7;
@property (strong, nonatomic) IBOutlet UIButton *cloud8;
@property (strong, nonatomic) IBOutlet UIButton *cloud9;

@property (strong, nonatomic) IBOutlet UIImageView *error1;
@property (strong, nonatomic) IBOutlet UIImageView *error2;
@property (strong, nonatomic) IBOutlet UIImageView *error3;

@property (nonatomic, retain) IBOutletCollection(UIButton)NSMutableArray *buttonsArray;
@property (strong, nonatomic) IBOutlet UILabel *targetValue;

@property (strong, nonatomic) IBOutlet UILabel *timer;
@property (strong, nonatomic) IBOutlet UIImageView *clock;
@property BOOL cloudClicked1,cloudClicked2,cloudClicked3,cloudClicked4,cloudClicked5,cloudClicked6,cloudClicked7,cloudClicked8,cloudClicked9;
@property int presentValue, medalCounter, coinsInt;
@property int uncatchedCloudCounter, wrongAnswerCounter;

@end
