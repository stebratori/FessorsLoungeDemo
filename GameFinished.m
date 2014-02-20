//
//  GameFinished.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 13/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "GameFinished.h"
#import "Constants.h"

@interface GameFinished ()

@end

@implementation GameFinished


-(void)viewWillAppear:(BOOL)animated
{
    _coins.text=[NSString stringWithFormat:@"%d",[Constants shared].lastGameScore];
}


-(IBAction)removeBck:(UIButton*)sender
{
    [_background removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated
{
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spin.fromValue = [NSNumber numberWithFloat:0.0f];
    spin.toValue = [NSNumber numberWithFloat:2*3.14];
    spin.duration = 25.0f;
    spin.repeatCount=999;
    
    [_background.layer addAnimation:spin forKey:@"mspin"];
    
    [UIView animateWithDuration:2
                     animations:^(void){
                         _fessor.frame = (CGRectMake(-60, _fessor.frame.origin.y, _fessor.frame.size.width, _fessor.frame.size.height));
                     }completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)rerun:(UIButton*)sender
{
    switch ([Constants shared].previousPlayedGame) {
        case 1:
            [self performSegueWithIdentifier:@"restartSkyfall" sender:self];
           break;

        case 2:
            [self performSegueWithIdentifier:@"restartDragAndDrop" sender:self];
           break;
    
        case 3:
            [self performSegueWithIdentifier:@"restartGameboard" sender:self];
            break;
    
        case 4:
            [self performSegueWithIdentifier:@"restartMemoryGame" sender:self];
            break;
    }
    
}

@end
