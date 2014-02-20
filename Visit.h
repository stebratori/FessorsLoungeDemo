//
//  Visit.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 18/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Visit : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *room;
@property (strong, nonatomic) IBOutlet UIImageView *fessor;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UIImageView *playCloud1;
@property (strong, nonatomic) IBOutlet UIImageView *playCloud2;
@property (strong, nonatomic) IBOutlet UIButton *playCloudEquation;

@property (strong, nonatomic) IBOutlet UIButton *playCloudAnswer1;
@property (strong, nonatomic) IBOutlet UIButton *playCloudAnswer2;
@property (strong, nonatomic) IBOutlet UIButton *playCloudAnswer3;

@property (strong, nonatomic) IBOutlet UIButton *visitBtn;

-(IBAction)playVisitGame:(UIButton*)sender;
-(IBAction)answerVisitQuestion:(UIButton*)sender;
-(IBAction)visitAnotherPlayer:(UIStoryboardSegue *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *visitCoinsWon;
@property (strong, nonatomic) IBOutlet UILabel *visitCoinsWonInt;


@end
