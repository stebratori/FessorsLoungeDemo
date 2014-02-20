//
//  GameFinished.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 13/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameFinished : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) IBOutlet UIImageView *fessor;
@property (strong, nonatomic) IBOutlet UILabel *coins;

-(IBAction)rerun:(UIButton*)sender;
-(IBAction)removeBck:(UIButton*)sender;

@end
