//
//  Visit.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 18/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "Visit.h"
#import "Controller.h"
#import "Constants.h"
#import <AudioToolbox/AudioToolbox.h>

@interface Visit ()
@property NSString *equationString;
@property int equationInt;
@end

@implementation Visit

-(void)viewWillAppear:(BOOL)animated
{
    [self generateEquation];
}

-(void)viewDidLoad
{
    
   
}

-(void)declareVariables
{
    
}

-(IBAction)visitAnotherPlayer:(UIStoryboardSegue *)sender
{
    
}

-(IBAction)playVisitGame:(UIButton*)sender
{
    
    
   
    [UIView animateWithDuration:0.5f
                     animations:^(void){
                         _playCloud1.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(void){
                         _playCloud2.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5f
                          delay:1
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(void){
                         _playCloudEquation.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5f
                          delay:1.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(void){
                         
                         _playCloudAnswer1.alpha=1;
                         _playCloudAnswer2.alpha=2;
                         _playCloudAnswer3.alpha=3;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)answerVisitQuestion:(UIButton *)sender
{
    _playCloudAnswer1.userInteractionEnabled=NO;
    _playCloudAnswer2.userInteractionEnabled=NO;
    _playCloudAnswer3.userInteractionEnabled=NO;
    
    switch (sender.tag) {
        
        case 0:
            [self colorCloud:_playCloudAnswer1 forAnswer:[self answer:[[_playCloudAnswer1 currentTitle] integerValue]]];
            break;
            
        case 1:
            [self colorCloud:_playCloudAnswer2 forAnswer:[self answer:[[_playCloudAnswer2 currentTitle] integerValue]]];
            break;
            
        case 2:
            [self colorCloud:_playCloudAnswer3 forAnswer:[self answer:[[_playCloudAnswer3 currentTitle] integerValue]]];
            break;
    }

}

-(BOOL) answer:(int)answer
{
    
    if (answer == _equationInt){
        return true;
    }
    
    else {
        
        return false;
        
    }
}


-(void)colorCloud:(UIButton*) cloud forAnswer:(BOOL)answer
{
    
    // True answer
    
    if (answer){
        [cloud setBackgroundImage: [UIImage imageNamed:@"cloudGreen.png"] forState:UIControlStateNormal];
        
        switch (cloud.tag) {
            case 0:
                _visitCoinsWon.frame = CGRectMake(80, 360, 67, 51);
                _visitCoinsWonInt.frame = CGRectMake(150, 360, 85, 51);
                

                break;
                
            case 1:
                _visitCoinsWon.frame = CGRectMake(210, 360, 67, 51);
                _visitCoinsWonInt.frame = CGRectMake(290, 360, 85, 51);
                break;
                
            case 2:
                _visitCoinsWon.frame = CGRectMake(350, 360, 67, 51);
                _visitCoinsWonInt.frame = CGRectMake(430, 360, 85, 51);
                break;
        }
        
        _visitCoinsWon.hidden=NO;
        _visitCoinsWonInt.hidden=NO;
        
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^(void){
                             
                             _visitCoinsWon.frame = (CGRectMake(_visitCoinsWon.frame.origin.x, _visitCoinsWon.frame.origin.y-70, _visitCoinsWon.frame.size.width, _visitCoinsWon.frame.size.height));
                             
                             _visitCoinsWonInt.frame = (CGRectMake(_visitCoinsWonInt.frame.origin.x, _visitCoinsWonInt.frame.origin.y-70, _visitCoinsWonInt.frame.size.width, _visitCoinsWonInt.frame.size.height));
                         }
                         completion:^(BOOL finished){
                             _visitCoinsWon.hidden=YES;
                             _visitCoinsWonInt.hidden=YES;
                         }];
        
    }
    
    // False answer
    
    else{
        
       [cloud setBackgroundImage: [UIImage imageNamed:@"cloudRed.png"] forState:UIControlStateNormal];
        
        if ([[_playCloudAnswer1 currentTitle] integerValue] == _equationInt){
            
            [_playCloudAnswer1 setBackgroundImage: [UIImage imageNamed:@"cloudGreen.png"] forState:UIControlStateNormal];
        }
        if ([[_playCloudAnswer2 currentTitle] integerValue] == _equationInt){
            
            [_playCloudAnswer2 setBackgroundImage: [UIImage imageNamed:@"cloudGreen.png"] forState:UIControlStateNormal];
        }
        if ([[_playCloudAnswer3 currentTitle] integerValue] == _equationInt){
            
            [_playCloudAnswer3 setBackgroundImage: [UIImage imageNamed:@"cloudGreen.png"] forState:UIControlStateNormal];
        }
    }
}

-(void)generateEquation
{
    int from = 2;
    int to = 10;
    
    int result = from + arc4random()%(to-from);
    NSString* answer2 = [[Controller shared] generateRandom:result fromValue:from toValue:to];
    NSString* answer3 = [[Controller shared] generateRandom:result differentFrom:[answer2 integerValue] fromValue:from toValue:to];
    _equationString = [[Controller shared] equationMaker:result forOperation:0];
    _equationInt = result;
    [_playCloudEquation setTitle:_equationString forState:UIControlStateNormal];
    int position = 1 + arc4random() % (4-1);
        
    switch (position) {
        case 1:
            [_playCloudAnswer1 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
            [_playCloudAnswer2 setTitle:answer2 forState:UIControlStateNormal];
            [_playCloudAnswer3 setTitle:answer3 forState:UIControlStateNormal];
            break;
            
        case 2:
            [_playCloudAnswer2 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
            [_playCloudAnswer1 setTitle:answer2 forState:UIControlStateNormal];
            [_playCloudAnswer3 setTitle:answer3 forState:UIControlStateNormal];
            break;
            
        case 3:
            [_playCloudAnswer3 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
            [_playCloudAnswer2 setTitle:answer2 forState:UIControlStateNormal];
            [_playCloudAnswer1 setTitle:answer3 forState:UIControlStateNormal];
            break;
    }
}



@end
