//
//  GameBoard.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "GameBoard.h"
#import "Constants.h"
#import "Controller.h"

#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

@interface GameBoard ()

@end

@implementation GameBoard
-(void)viewDidLoad
{
    [self setPace];
    [self declareVariables];
    [self generateEquation];
    //[self dressFessor];
}


-(IBAction)startGameBoard:(UIStoryboardSegue *)sender
{
    
}



- (IBAction)generateEquation

{
    
    if(_points<7){
        
        
        
        int result = 3 + arc4random() % (10-3);
        
        NSString* answer2 = [[Controller shared] generateRandom:result fromValue:3 toValue:10];
        NSString* answer3 = [[Controller shared] generateRandom:result differentFrom:[answer2 integerValue] fromValue:3 toValue:10];
        NSString* answer4 = [[Controller shared] generateRandom:result differentFrom:[answer2 integerValue] andDifferentFrom:[answer3 integerValue] fromValue:3 toValue:10];
        
        NSString* generated_equation = [[Controller shared] equationMaker:result forOperation:[Constants shared].presentOperation];
        _equation = [[Controller shared] equationDecoder:generated_equation];
        [_cloudQuestion setTitle:generated_equation forState:UIControlStateNormal];
        
        int position =arc4random() % 4;
        
        switch (position) {
                
            case 0:
                [_cloudAnswer1 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
                [_cloudAnswer2 setTitle:answer2 forState:UIControlStateNormal];
                [_cloudAnswer3 setTitle:answer3 forState:UIControlStateNormal];
                [_cloudAnswer4 setTitle:answer4 forState:UIControlStateNormal];
                break;
                
            case 1:
                [_cloudAnswer2 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
                [_cloudAnswer1 setTitle:answer2 forState:UIControlStateNormal];
                [_cloudAnswer3 setTitle:answer3 forState:UIControlStateNormal];
                [_cloudAnswer4 setTitle:answer4 forState:UIControlStateNormal];
                break;
                
            case 2:
                [_cloudAnswer3 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
                [_cloudAnswer2 setTitle:answer2 forState:UIControlStateNormal];
                [_cloudAnswer1 setTitle:answer3 forState:UIControlStateNormal];
                [_cloudAnswer4 setTitle:answer4 forState:UIControlStateNormal];
                break;
                
            case 3:
                [_cloudAnswer4 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
                [_cloudAnswer2 setTitle:answer2 forState:UIControlStateNormal];
                [_cloudAnswer3 setTitle:answer3 forState:UIControlStateNormal];
                [_cloudAnswer1 setTitle:answer4 forState:UIControlStateNormal];
                break;
        }
        
        [self enableClouds];
        
    }
    else {
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self endGame];
        });
        
    }
    
}

-(void)endGame
{
    [Constants shared].coins+=7;
    [Constants shared].lastGameScore = 7;
    [self performSegueWithIdentifier:@"board_game_done" sender:self];
}

-(void)disableClouds
{
    _cloudAnswer1.enabled = NO;
    _cloudAnswer2.enabled = NO;
    _cloudAnswer3.enabled = NO;
    _cloudAnswer4.enabled = NO;
    
    _cloudAnswer1.adjustsImageWhenDisabled = NO;
    _cloudAnswer2.adjustsImageWhenDisabled = NO;
    _cloudAnswer3.adjustsImageWhenDisabled = NO;
    _cloudAnswer4.adjustsImageWhenDisabled = NO;
}

-(void)enableClouds
{
    _cloudAnswer1.enabled = YES;
    _cloudAnswer2.enabled = YES;
    _cloudAnswer3.enabled = YES;
    _cloudAnswer4.enabled = YES;
}

-(IBAction)cloudClick:(UIButton*)sender
{
    
    
    switch (sender.tag) {
            
        case 1:
            [self colorCloud:_cloudAnswer1 forAnswer:[self answer:[[_cloudAnswer1 currentTitle] integerValue]]];
            break;
            
        case 2:
            [self colorCloud:_cloudAnswer2 forAnswer:[self answer:[[_cloudAnswer2 currentTitle] integerValue]]];
            break;
            
        case 3:
            [self colorCloud:_cloudAnswer3 forAnswer:[self answer:[[_cloudAnswer3 currentTitle] integerValue]]];
            break;
            
        case 4:
            [self colorCloud:_cloudAnswer4 forAnswer:[self answer:[[_cloudAnswer4 currentTitle] integerValue]]];
            break;
    }
    
    
    [self disableClouds];
    
}

-(BOOL) answer:(int)answer
{
    if (answer == _equation){
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
        [cloud setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            _points++;
            _gameboardCoins.text = [NSString stringWithFormat:@"%d",_points];
            [self moveFessor];
            
            // last answered cloud stays colored
            if (_points<7){
                [cloud setBackgroundImage: _whiteCloud forState:UIControlStateNormal];
            }
            
        });
    }
    
    // False answer
    
    else{
        
        _medalCounter=_medalCounter+1;
        
        
        [cloud setBackgroundImage: _redCloud forState:UIControlStateNormal];
        
        if ([[_cloudAnswer1 currentTitle] integerValue] == _equation){
            
            [_cloudAnswer1 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        if ([[_cloudAnswer2 currentTitle] integerValue] == _equation){
            
            [_cloudAnswer2 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        if ([[_cloudAnswer3 currentTitle] integerValue] == _equation){
            
            [_cloudAnswer3 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        if ([[_cloudAnswer4 currentTitle] integerValue] == _equation){
            
            [_cloudAnswer4 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            
            [self resetClouds];
            
        });
    }
    
    
    
    
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        
        [self generateEquation];
    });
    
    
    
    
}

-(IBAction)resetClouds
{
    [_cloudAnswer1 setBackgroundImage:_whiteCloud forState:UIControlStateNormal];
    [_cloudAnswer2 setBackgroundImage:_whiteCloud forState:UIControlStateNormal];
    [_cloudAnswer3 setBackgroundImage:_whiteCloud forState:UIControlStateNormal];
    [_cloudAnswer4 setBackgroundImage:_whiteCloud forState:UIControlStateNormal];
    
    
    
    
}

-(void)declareVariables
{
    
    [Constants shared].previousPlayedGame=3;
    _greenCloud = [UIImage imageNamed:@"cloudGreen.png"];
    _redCloud = [UIImage imageNamed:@"cloudRed.png"];
    _whiteCloud = [UIImage imageNamed:@"cloudWhite.png"];
    
    _medalCounter = 0;
    _points = 0;
    
    _gold = [UIImage imageNamed:@"gold.png" ];
    _silver = [UIImage imageNamed:@"silver.png" ];
    _bronze = [UIImage imageNamed:@"bronze.png" ];
    
    _iceland = [UIImage imageNamed:@"iceland2.png" ];
    _faroe = [UIImage imageNamed:@"faroe1.png" ];
    _norway = [UIImage imageNamed:@"norway1.png" ];
    _denmark = [UIImage imageNamed:@"denmark1.png" ];
    _sweden = [UIImage imageNamed:@"sweden1.png" ];
    _finland = [UIImage imageNamed:@"finland1.png" ];
    
    _blinkCounter = 3;
    
    _regular = [UIImage imageNamed:@"costumeFessor.png" ];
    _hero = [UIImage imageNamed:@"costumeHero.png" ];
    _cowboy = [UIImage imageNamed:@"costumeCowboy.png" ];
    _indian = [UIImage imageNamed:@"costumeIndian.png" ];
    _pirate = [UIImage imageNamed:@"costumePirate.png" ];
    _viking = [UIImage imageNamed:@"costumeViking.png" ];
    
    _cloudAnswer1.exclusiveTouch = YES;
    _cloudAnswer2.exclusiveTouch = YES;
    
    _cloudAnswer3.exclusiveTouch = YES;
    
    _cloudAnswer4.exclusiveTouch = YES;
    
    
}



-(void)moveFessor

{
    [UIView beginAnimations:nil context:NULL];
    
    
    // iPAD //
    
    
    if ([self isiPad]== YES)
    {
        
        if (_points == 7){
            [UIView setAnimationDuration:0.5];
            _fessor.frame = (CGRectMake(_fessor.frame.origin.x + _pace +100, _fessor.frame.origin.y, _fessor.frame.size.width, _fessor.frame.size.height));
            [UIView commitAnimations];
        }
        else
        {
            [UIView setAnimationDuration:0.5];
            _fessor.frame = (CGRectMake(_fessor.frame.origin.x + _pace , _fessor.frame.origin.y, _fessor.frame.size.width, _fessor.frame.size.height));
            [UIView commitAnimations];
        }
    }
    else{
        
        
        if (_points == 7){
            [UIView setAnimationDuration:0.5];
            _fessor.frame = (CGRectMake(_fessor.frame.origin.x + _pace +133, _fessor.frame.origin.y, _fessor.frame.size.width, _fessor.frame.size.height));
            [UIView commitAnimations];
        }
        else
        {
            [UIView setAnimationDuration:0.5];
            _fessor.frame = (CGRectMake(_fessor.frame.origin.x + _pace, _fessor.frame.origin.y, _fessor.frame.size.width, _fessor.frame.size.height));
            [UIView commitAnimations];
        }
    }
}



-(BOOL) isiPad {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return YES;
    }else {
        return NO;
    }
}



-(void)setPace
{
    if ([self isiPad] == YES)
    {
        CGFloat screenWidth = _theDoors.frame.origin.x;
        CGFloat fessorSpot = _fessor.frame.origin.x;
        CGFloat floatPace = (screenWidth - fessorSpot)/7;
        
        _pace = (int)floatPace;
    }
    
    else
    {
        CGFloat screenWidth = _theDoors.frame.origin.x;
        CGFloat fessorSpot = _fessor.frame.origin.x;
        CGFloat floatPace = (screenWidth - fessorSpot)/7+15;
        
        _pace = (int)floatPace;
    }
    
    
}



-(void)dressFessor
{
    switch ([Constants shared].presentFessorCostume) {
            
        case 0:
            _fessor.image = _regular;
            break;
            
        case 1:
            _fessor.image = _hero;
            break;
            
        case 2:
            _fessor.image = _cowboy;
            break;
            
        case 3:
            _fessor.image = _indian;
            break;
            
        case 4:
            _fessor.image = _pirate;
            break;
            
        case 5:
            _fessor.image = _viking;
            break;
    }
}



@end
