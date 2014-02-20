//
//  MemoryGame.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "MemoryGame.h"
#import "Controller.h"
#import "Constants.h"

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface MemoryGame ()

@end

@implementation MemoryGame



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self declareVariables];
    //[self setBackground];
    [self setButtons];
   // [self dressFessor];
    
	
}

-(void)viewWillAppear:(BOOL)animated
{
    [self populateTable:_memoryGameSize];
    
}

-(IBAction)startMemoryGame:(UIStoryboardSegue *)sender
{
}

-(void)declareVariables
{
    //Memory Game Size
    _memoryGameSize = 16;
    [Constants shared].previousPlayedGame=4;
    
    _counter = 0;
    _medalCounter = 0;
    _score = 0;
    _denmark = [UIImage imageNamed:@"denmark_btn" ];
    _white_button = [UIImage imageNamed:@"white_button" ];
    
    _bonusCounter =0;
    _bonusTriggered = NO;
    
    _regular = [UIImage imageNamed:@"costumeFessor.png" ];
    _hero = [UIImage imageNamed:@"costumeHero.png" ];
    _cowboy = [UIImage imageNamed:@"costumeCowboy.png" ];
    _indian = [UIImage imageNamed:@"costumeIndian.png" ];
    _pirate = [UIImage imageNamed:@"costumePirate.png" ];
    _viking = [UIImage imageNamed:@"costumeViking.png" ];
    
    _btn11.exclusiveTouch = YES;
    _btn12.exclusiveTouch = YES;
    _btn13.exclusiveTouch = YES;
    _btn14.exclusiveTouch = YES;
    
    _btn21.exclusiveTouch = YES;
    _btn22.exclusiveTouch = YES;
    _btn23.exclusiveTouch = YES;
    _btn24.exclusiveTouch = YES;
    
    _btn31.exclusiveTouch = YES;
    _btn32.exclusiveTouch = YES;
    _btn33.exclusiveTouch = YES;
    _btn34.exclusiveTouch = YES;
    
    _btn41.exclusiveTouch = YES;
    _btn42.exclusiveTouch = YES;
    _btn43.exclusiveTouch = YES;
    _btn44.exclusiveTouch = YES;
    
    _revealed11 = NO;
    _revealed12 = NO;
    _revealed13 = NO;
    _revealed14 = NO;
    
    _revealed21 = NO;
    _revealed22 = NO;
    _revealed23 = NO;
    _revealed24 = NO;
    
    _revealed31 = NO;
    _revealed32 = NO;
    _revealed33 = NO;
    _revealed34 = NO;
    
    _revealed41 = NO;
    _revealed42 = NO;
    _revealed43 = NO;
    _revealed44 = NO;
    
    
    
    _greenCloud = [UIImage imageNamed:@"cloudGreen.png"];
    _redCloud = [UIImage imageNamed:@"cloudRed.png"];
    _whiteCloud = [UIImage imageNamed:@"cloudWhite.png"];
    
}



-(IBAction)controller:(UIButton*)sender
{
    
    
    
    
    UILabel* textLabel = [self getLabel:sender.tag];
    [sender setBackgroundImage:_white_button forState:UIControlStateNormal];
    textLabel.hidden = NO;
    _stringValue= textLabel.text;
    
    
    // First button pressed
    
    if (_counter == 0)
        
    {
        _btnClicked1 = sender;
        _txtClicked1 = textLabel;
        //  if it's an equation
        if (_stringValue.length > 1){
            
            _firstValue = [[Controller shared] equationDecoder:_stringValue];
            
            
            // if it's a single value
        }else {
            
            _firstValue = [textLabel.text integerValue];
        }
        
        sender.enabled = NO;
        _counter = 1;
        
    }
    
    
    // Second button pressed
    else
    {
        [self disableButtons];
        _btnClicked2 = sender;
        _txtClicked2 = textLabel;
        
        //  if it's an equation
        if (_stringValue.length > 1){
            
            _secondValue = [[Controller shared] equationDecoder:_stringValue];
            
            
            // if it's a single value
        }else {
            
            _secondValue = [textLabel.text integerValue];
        }
        
        _result = _secondValue - _firstValue;
        
        
        /////////////////////
        /// Correct match ///
        /////////////////////
        
        if (_result == 0){
            
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [self createRunnable:TRUE forBtn:_btnClicked1 andBtn:_btnClicked2 forTxt:_txtClicked1 andTxt:_txtClicked2];
                
            });
            
            int guess = arc4random() % 5;
            
            
            // ** triggering a bonus ** //
            
            
            if(guess == 3 & _bonusCounter < 4 & _score!=7){
                [self disableButtons];
                [self triggerBonus];
                _bonusCounter++;
                
            }
            
            if (_score == 6 & _bonusCounter == 0){
                [self triggerBonus];
            }
            
            
            
        }
        
        // Wrong match
        else{
            if ([self getRevealed:sender.tag]==YES) {
                _medalCounter++;
                
            }
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self createRunnable:FALSE forBtn:_btnClicked1 andBtn:_btnClicked2 forTxt:_txtClicked1 andTxt:_txtClicked2];
            });
            
        }
        
        _counter = 0;
    }
    [self setRevealed:sender.tag];
    
}


#pragma Bonus

-(IBAction)cloudClick :(UIButton*)sender
{
    
    
    switch (sender.tag) {
            
        case 1:
            [self colorCloud:_cloud1 forAnswer:[self answer:[[_cloud1 currentTitle] integerValue]]];
            
            break;
            
        case 2:
            [self colorCloud:_cloud2 forAnswer:[self answer:[[_cloud2 currentTitle] integerValue]]];
            break;
            
        case 3:
            [self colorCloud:_cloud3 forAnswer:[self answer:[[_cloud3 currentTitle] integerValue]]];
            break;
    }
    
    
}


-(void)triggerBonus
{
    
    
    [self generateEquation];
    [self alfaDecrease];
    
    
    //_bonusContainer.hidden = NO;
    
    
    // show the bonus
    _bonusLabel.hidden = NO;
    _bonusBck.hidden = NO;
    _cloud1.hidden = NO;
    _cloud2.hidden = NO;
    _cloud3.hidden = NO;
    _bonusFessor.hidden = NO;
    _timer.hidden = NO;
    _bonusClock.hidden=NO;
    _bonusTriggered = YES;
    
    
    // ticking
    [self tickOnce];
    [self tickTwice];
    [self tickThree];
    [self tickFour];
    [self tickZero];
    
    
    
    
    //removing the bonus
    
    double delayInSeconds = 5.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        //_bonusContainer.hidden = YES;
        
        [self alfaIncrease];
        _bonusTriggered = NO;
        //[_timer removeFromSuperview];
        _bonusClock.hidden=YES;
        _bonusLabel.hidden = YES;
        _bonusBck.hidden = YES;
        _cloud1.hidden = YES;
        _cloud2.hidden = YES;
        _cloud3.hidden = YES;
        _bonusFessor.hidden = YES;
        _timer.hidden = YES;
        
        
        // resetAllValues
        [self generateEquation];
        [self resetClouds];
    });
    
    
}

- (void)generateEquation

{
   
    
    int result = 3 + arc4random() % (10-3);
    
    NSString* answer2 = [[Controller shared] generateRandom:result fromValue:3 toValue:10];
    NSString* answer3 = [[Controller shared] generateRandom:result differentFrom:[answer2 integerValue] fromValue:3 toValue:10];
    
    
    NSString* generated_equation = [[Controller shared] equationMaker:result forOperation:[Constants shared].presentOperation];
    
    _equationInt = [[Controller shared] equationDecoder:generated_equation];
    _bonusLabel.text = generated_equation;
    int position =arc4random() % 3;
    
    switch (position) {
            
        case 0:
            [_cloud1 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
            [_cloud2 setTitle:answer2 forState:UIControlStateNormal];
            [_cloud3 setTitle:answer3 forState:UIControlStateNormal];
            
            break;
            
        case 1:
            [_cloud2 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
            [_cloud1 setTitle:answer2 forState:UIControlStateNormal];
            [_cloud3 setTitle:answer3 forState:UIControlStateNormal];
            
            break;
            
        case 2:
            [_cloud3 setTitle:[NSString stringWithFormat:@"%d",result] forState:UIControlStateNormal];
            [_cloud2 setTitle:answer2 forState:UIControlStateNormal];
            [_cloud1 setTitle:answer3 forState:UIControlStateNormal];
            
            break;
            
            
    }
    
    [self enableClouds];
    
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

-(void)disableClouds
{
    _cloud1.enabled = NO;
    _cloud2.enabled = NO;
    _cloud3.enabled = NO;
    
    _cloud1.adjustsImageWhenDisabled = NO;
    _cloud2.adjustsImageWhenDisabled = NO;
    _cloud3.adjustsImageWhenDisabled = NO;
}

-(void)enableClouds
{
    _cloud1.enabled = YES;
    _cloud2.enabled = YES;
    _cloud3.enabled = YES;
    
}

-(void)resetClouds
{
    [_cloud1 setBackgroundImage: _whiteCloud forState:UIControlStateNormal];
    [_cloud2 setBackgroundImage: _whiteCloud forState:UIControlStateNormal];
    [_cloud3 setBackgroundImage: _whiteCloud forState:UIControlStateNormal];
    
    _timer.text=@"00:05";
}

-(void)colorCloud:(UIButton*) cloud forAnswer:(BOOL)answer
{
    
    [self disableClouds];
    
    // True answer
    if (answer){
        
        [cloud setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        
    }
    
    
    // False answer
    else{
        
        [cloud setBackgroundImage: _redCloud forState:UIControlStateNormal];
        
        if ([[_cloud1 currentTitle] integerValue] == _equationInt){
            
            [_cloud1 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        if ([[_cloud2 currentTitle] integerValue] == _equationInt){
            
            [_cloud2 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        if ([[_cloud3 currentTitle] integerValue] == _equationInt){
            
            [_cloud3 setBackgroundImage: _greenCloud forState:UIControlStateNormal];
        }
        
    }
    
    
    
    
    
    
    
}

-(BOOL) isiPad {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

-(void)createTimer
{
    _timer = [[UILabel alloc] init];
    
    if ([self isiPad]){
        [_timer setFrame:CGRectMake(425, 94, 180, 58)];
        _timer.font = [UIFont systemFontOfSize:70];
    }
    else{
        [_timer setFrame:CGRectMake(15,150, 88, 29)];
        _timer.font = [UIFont systemFontOfSize:35];
    }
    
    
    
    
    
    
    _timer.backgroundColor=[UIColor clearColor];
    _timer.textColor=[UIColor redColor];
    _timer.userInteractionEnabled=YES;
    
    
    [self.view addSubview:_timer];
    // _timer.text= @"00:03";
    
    // new
    _timer.text=@"00:05";
}

-(void)tickOnce
{
    
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _timer.text = @"00:04";
    });
}

-(void)tickTwice
{
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _timer.text = @"00:03";
    });
}

-(void)tickThree
{
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _timer.text = @"00:02";
    });
}

-(void)tickFour
{
    double delayInSeconds = 4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _timer.text = @"00:01";
    });
}

-(void)tickZero
{
    double delayInSeconds = 5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _timer.text = @"00:00";
    });
}

-(void)alfaDecrease
{
    [self disableButtons];
    
    [_fessor setAlpha:0.7];
    
    [_btn11 setAlpha:0.7];
    [_btn12 setAlpha:0.7];
    [_btn13 setAlpha:0.7];
    [_btn14 setAlpha:0.7];
    
    [_btn21 setAlpha:0.7];
    [_btn22 setAlpha:0.7];
    [_btn23 setAlpha:0.7];
    [_btn24 setAlpha:0.7];
    
    [_btn31 setAlpha:0.7];
    [_btn32 setAlpha:0.7];
    [_btn33 setAlpha:0.7];
    [_btn34 setAlpha:0.7];
    
    [_btn41 setAlpha:0.7];
    [_btn42 setAlpha:0.7];
    [_btn43 setAlpha:0.7];
    [_btn44 setAlpha:0.7];
    
    [_memoryGame setAlpha:0.7];
}

-(void)alfaIncrease
{
    [self enableButtons];
    
    [_fessor setAlpha:1];
    
    [_btn11 setAlpha:1];
    [_btn12 setAlpha:1];
    [_btn13 setAlpha:1];
    [_btn14 setAlpha:1];
    
    [_btn21 setAlpha:1];
    [_btn22 setAlpha:1];
    [_btn23 setAlpha:1];
    [_btn24 setAlpha:1];
    
    [_btn31 setAlpha:1];
    [_btn32 setAlpha:1];
    [_btn33 setAlpha:1];
    [_btn34 setAlpha:1];
    
    [_btn41 setAlpha:1];
    [_btn42 setAlpha:1];
    [_btn43 setAlpha:1];
    [_btn44 setAlpha:1];
    
    [_memoryGame setAlpha:1];
}

-(void)finishGame
{
    [Constants shared].coins+=_bonus+8;
    [Constants shared].lastGameScore = _bonus+8;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.9];
    _fessor.frame = (CGRectMake([UIScreen mainScreen].bounds.size.height, _fessor.frame.origin.y, _fessor.frame.size.width, _fessor.frame.size.height));
    [UIView commitAnimations];
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.fessor.hidden = YES;
        [self performSegueWithIdentifier:@"memory_game_done" sender:self];
    });
}

-(void)createRunnable:(BOOL) guessed forBtn:(UIButton*) btn1 andBtn:(UIButton*) btn2 forTxt:(UILabel*) txt1 andTxt:(UILabel*) txt2
{
    if (guessed){
        _btnClicked1.hidden = TRUE;
        _txtClicked1.hidden = TRUE;
        _btnClicked2.hidden = TRUE;
        _txtClicked2.hidden = TRUE;
        _score=_score+1;
        _memoryGameCoins.text = [NSString stringWithFormat:@"%d",_score];
        
        switch (_memoryGameSize) {
                
            case 16:
                if (_score == 8){
                    [self finishGame];
                }
                break;
                
                
            case 12:
                if (_score == 6){
                    [self finishGame];
                }
                break;
                
                
            case 9:
                if (_score == 4){
                    [self finishGame];
                }
                break;
        }
        
        
        
    }
    else {
        [self setButtons];
        _txtClicked1.hidden = true;
        _txtClicked2.hidden = true;
        
    }
    if (_bonusTriggered == NO){
        [self enableButtons ];
    }
    
}



-(void)medalListener
{
    // End blinking !
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        _memoryGameMedal.alpha = 1.0;
        
    });
    
    
    // Start blinking !
    
    if( _medalCounter == 3 )
    {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationRepeatCount:3.0];
        [UIView setAnimationRepeatAutoreverses:YES];
        
        _memoryGameMedal.alpha = 0.5;
        
        [UIView commitAnimations];
    }
    
    if(  _medalCounter == 8)
    {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationRepeatCount:3.0];
        [UIView setAnimationRepeatAutoreverses:YES];
        
        _memoryGameMedal.alpha = 0.5;
        
        [UIView commitAnimations];
    }
    
}

-(void)setRevealed:(int)button
{
    switch (button) {
            
        case 11:
            _revealed11 = YES;
            break;
            
        case 12:
            _revealed12 = YES;
            break;
            
        case 13:
            _revealed13 = YES;
            break;
            
        case 14:
            _revealed14 = YES;
            break;
            
        case 21:
            _revealed21 = YES;
            break;
            
        case 22:
            _revealed22 = YES;
            break;
            
        case 23:
            _revealed23 = YES;
            break;
            
        case 24:
            _revealed14 = YES;
            break;
            
        case 31:
            _revealed31 = YES;
            break;
            
        case 32:
            _revealed32 = YES;
            break;
            
        case 33:
            _revealed33 = YES;
            break;
            
        case 34:
            _revealed34 = YES;
            break;
            
        case 41:
            _revealed41 = YES;
            break;
            
        case 42:
            _revealed42 = YES;
            break;
            
        case 43:
            _revealed43 = YES;
            break;
            
        case 44:
            _revealed44 = YES;
            break;
            
            
            
            
    }
}

-(BOOL)getRevealed:(int)button
{
    BOOL returnValue;
    
    switch (button) {
            
        case 11:
            if (_revealed11 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 12:
            if (_revealed12 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 13:
            if (_revealed13 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 14:
            if (_revealed14 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 21:
            if (_revealed21 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 22:
            if (_revealed22 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 23:
            if (_revealed23 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 24:
            if (_revealed24 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 31:
            if (_revealed31 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 32:
            if (_revealed32 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 33:
            if (_revealed33 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 34:
            if (_revealed34 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 41:
            if (_revealed41 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 42:
            if (_revealed42 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 43:
            if (_revealed43 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
        case 44:
            if (_revealed44 == YES) {
                returnValue=YES;
            }else {
                returnValue=NO;
            }
            
            break;
            
            
            
            
            
    }
    return returnValue;
    
}




-(IBAction)setButtons
{
    
            [_btn11 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn12 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn13 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn14 setBackgroundImage: _denmark forState:UIControlStateNormal];
            
            [_btn21 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn22 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn23 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn24 setBackgroundImage: _denmark forState:UIControlStateNormal];
            
            [_btn31 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn32 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn33 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn34 setBackgroundImage: _denmark forState:UIControlStateNormal];
            
            [_btn41 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn42 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn43 setBackgroundImage: _denmark forState:UIControlStateNormal];
            [_btn44 setBackgroundImage: _denmark forState:UIControlStateNormal];
}

-(UILabel*)getLabel:(int)tagNo
{
    
    
    switch (tagNo) {
            
        case 11:
            _labelClicked = _txt11;
            
            break;
            
        case 12:
            _labelClicked = _txt12;
            break;
            
        case 13:
            _labelClicked = _txt13;
            break;
            
        case 14:
            _labelClicked = _txt14;
            break;
            
            
        case 21:
            _labelClicked = _txt21;
            break;
            
        case 22:
            _labelClicked = _txt22;
            break;
            
        case 23:
            _labelClicked = _txt23;
            break;
            
        case 24:
            _labelClicked = _txt24;
            break;
            
            
        case 31:
            _labelClicked = _txt31;
            break;
            
        case 32:
            _labelClicked = _txt32;
            break;
            
        case 33:
            _labelClicked = _txt33;
            break;
            
        case 34:
            _labelClicked = _txt34;
            break;
            
            
        case 41:
            _labelClicked = _txt41;
            break;
            
        case 42:
            _labelClicked = _txt42;
            break;
            
        case 43:
            _labelClicked = _txt43;
            break;
            
        case 44:
            _labelClicked = _txt44;
            break;
    }
    
    return _labelClicked;
}

-(void)disableButtons
{
    _btn11.enabled=NO;
    _btn12.enabled=NO;
    _btn13.enabled=NO;
    _btn14.enabled=NO;
    
    _btn21.enabled=NO;
    _btn22.enabled=NO;
    _btn23.enabled=NO;
    _btn24.enabled=NO;
    
    _btn31.enabled=NO;
    _btn32.enabled=NO;
    _btn33.enabled=NO;
    _btn34.enabled=NO;
    
    _btn41.enabled=NO;
    _btn42.enabled=NO;
    _btn43.enabled=NO;
    _btn44.enabled=NO;
    
    _btn11.adjustsImageWhenDisabled=NO;
    _btn12.adjustsImageWhenDisabled=NO;
    _btn13.adjustsImageWhenDisabled=NO;
    _btn14.adjustsImageWhenDisabled=NO;
    
    _btn21.adjustsImageWhenDisabled=NO;
    _btn22.adjustsImageWhenDisabled=NO;
    _btn23.adjustsImageWhenDisabled=NO;
    _btn24.adjustsImageWhenDisabled=NO;
    
    _btn31.adjustsImageWhenDisabled=NO;
    _btn32.adjustsImageWhenDisabled=NO;
    _btn33.adjustsImageWhenDisabled=NO;
    _btn34.adjustsImageWhenDisabled=NO;
    
    _btn41.adjustsImageWhenDisabled=NO;
    _btn42.adjustsImageWhenDisabled=NO;
    _btn43.adjustsImageWhenDisabled=NO;
    _btn44.adjustsImageWhenDisabled=NO;
}

-(void)enableButtons
{
    _btn11.enabled=YES;
    _btn12.enabled=YES;
    _btn13.enabled=YES;
    _btn14.enabled=YES;
    
    _btn21.enabled=YES;
    _btn22.enabled=YES;
    _btn23.enabled=YES;
    _btn24.enabled=YES;
    
    _btn31.enabled=YES;
    _btn32.enabled=YES;
    _btn33.enabled=YES;
    _btn34.enabled=YES;
    
    _btn41.enabled=YES;
    _btn42.enabled=YES;
    _btn43.enabled=YES;
    _btn44.enabled=YES;
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

-(void)populateTable:(int)size
{
    
    NSArray *game;
    
    switch (size) {
        
        case 16:
            
            game = [[Controller shared] populateTable:16 for:[Constants shared].presentOperation];
            _txt11.text = [NSString stringWithFormat:@"%@",game[13]];
            _txt12.text = [NSString stringWithFormat:@"%@",game[14]];
            _txt13.text = [NSString stringWithFormat:@"%@",game[15]];
            _txt14.text = [NSString stringWithFormat:@"%@",game[12]];
            
            _txt21.text = [NSString stringWithFormat:@"%@",game[8]];
            _txt31.text = [NSString stringWithFormat:@"%@",game[9]];
            _txt33.text = [NSString stringWithFormat:@"%@",game[10]];
            _txt41.text = [NSString stringWithFormat:@"%@",game[11]];
            break;
            
        case 12:
            
            game = [[Controller shared] populateTable:12 for:[Constants shared].presentOperation];
            [self costumizeFor3x4];
            _btn11.hidden = YES;
            _btn12.hidden = YES;
            _btn13.hidden = YES;
            _btn14.hidden = YES;
            
            _txt21.text = [NSString stringWithFormat:@"%@",game[8]];
            _txt31.text = [NSString stringWithFormat:@"%@",game[9]];
            _txt33.text = [NSString stringWithFormat:@"%@",game[10]];
            _txt41.text = [NSString stringWithFormat:@"%@",game[11]];
            break;
            
        case 9:
            game = [[Controller shared] populateTable:9 for:[Constants shared].presentOperation];
            [self costumizeFor3x3];
            _btn11.hidden = YES;
            _btn12.hidden = YES;
            _btn13.hidden = YES;
            _btn14.hidden = YES;
            
            _btn21.hidden = YES;
            _btn31.hidden = YES;
            _btn33.hidden = YES;
            _btn41.hidden = YES;
            break;
    }
    
    _txt22.text = [NSString stringWithFormat:@"%@",game[0]];
    _txt23.text = [NSString stringWithFormat:@"%@",game[1]];
    _txt24.text = [NSString stringWithFormat:@"%@",game[2]];
    
    _txt32.text = [NSString stringWithFormat:@"%@",game[3]];
    _txt34.text = [NSString stringWithFormat:@"%@",game[4]];
    
    _txt42.text = [NSString stringWithFormat:@"%@",game[5]];
    _txt43.text = [NSString stringWithFormat:@"%@",game[6]];
    _txt44.text = [NSString stringWithFormat:@"%@",game[7]];
    
}

-(void)costumizeFor3x4

{
    
    CGRect frame21 = [_btn21 frame];
    CGRect frame22 = [_btn22 frame];
    CGRect frame23 = [_btn23 frame];
    CGRect frame24 = [_btn24 frame];
    
    CGRect frame31 = [_btn31 frame];
    CGRect frame32 = [_btn32 frame];
    CGRect frame33 = [_btn33 frame];
    CGRect frame34 = [_btn34 frame];
    
    CGRect frame41 = [_btn41 frame];
    CGRect frame42 = [_btn42 frame];
    CGRect frame43 = [_btn43 frame];
    CGRect frame44 = [_btn44 frame];
    
    
    if ([self isiPad]){
        
        frame21.origin.y -= 60;
        [_btn21 setFrame:frame21];
        frame22.origin.y -= 60;
        [_btn22 setFrame:frame22];
        frame23.origin.y -= 60;
        [_btn23 setFrame:frame23];
        frame24.origin.y -= 60;
        [_btn24 setFrame:frame24];
        
        frame31.origin.y -= 60;
        [_btn31 setFrame:frame31];
        frame32.origin.y -= 60;
        [_btn32 setFrame:frame32];
        frame33.origin.y -= 60;
        [_btn33 setFrame:frame33];
        frame34.origin.y -= 60;
        [_btn34 setFrame:frame34];
        
        frame41.origin.y -= 60;
        [_btn41 setFrame:frame41];
        frame42.origin.y -= 60;
        [_btn42 setFrame:frame42];
        frame43.origin.y -= 60;
        [_btn43 setFrame:frame43];
        frame44.origin.y -= 60;
        [_btn44 setFrame:frame44];
        
    } else{
        frame21.origin.y -= 35;
        [_btn21 setFrame:frame21];
        frame22.origin.y -= 35;
        [_btn22 setFrame:frame22];
        frame23.origin.y -= 35;
        [_btn23 setFrame:frame23];
        frame24.origin.y -= 35;
        [_btn24 setFrame:frame24];
        
        frame31.origin.y -= 35;
        [_btn31 setFrame:frame31];
        frame32.origin.y -= 35;
        [_btn32 setFrame:frame32];
        frame33.origin.y -= 35;
        [_btn33 setFrame:frame33];
        frame34.origin.y -= 35;
        [_btn34 setFrame:frame34];
        
        frame41.origin.y -= 35;
        [_btn41 setFrame:frame41];
        frame42.origin.y -= 35;
        [_btn42 setFrame:frame42];
        frame43.origin.y -= 35;
        [_btn43 setFrame:frame43];
        frame44.origin.y -= 35;
        [_btn44 setFrame:frame44];
    }
    
    [self moveText3x4];
    
}

-(void)moveText3x4
{
    
    
    CGRect frame21 = [_txt21 frame];
    CGRect frame22 = [_txt22 frame];
    CGRect frame23 = [_txt23 frame];
    CGRect frame24 = [_txt24 frame];
    
    CGRect frame31 = [_txt31 frame];
    CGRect frame32 = [_txt32 frame];
    CGRect frame33 = [_txt33 frame];
    CGRect frame34 = [_txt34 frame];
    
    CGRect frame41 = [_txt41 frame];
    CGRect frame42 = [_txt42 frame];
    CGRect frame43 = [_txt43 frame];
    CGRect frame44 = [_txt44 frame];
    
    
    if ([self isiPad]){
        
        frame21.origin.y -= 60;
        [_txt21 setFrame:frame21];
        frame22.origin.y -= 60;
        [_txt22 setFrame:frame22];
        frame23.origin.y -= 60;
        [_txt23 setFrame:frame23];
        frame24.origin.y -= 60;
        [_txt24 setFrame:frame24];
        
        frame31.origin.y -= 60;
        [_txt31 setFrame:frame31];
        frame32.origin.y -= 60;
        [_txt32 setFrame:frame32];
        frame33.origin.y -= 60;
        [_txt33 setFrame:frame33];
        frame34.origin.y -= 60;
        [_txt34 setFrame:frame34];
        
        frame41.origin.y -= 60;
        [_txt41 setFrame:frame41];
        frame42.origin.y -= 60;
        [_txt42 setFrame:frame42];
        frame43.origin.y -= 60;
        [_txt43 setFrame:frame43];
        frame44.origin.y -= 60;
        [_txt44 setFrame:frame44];
        
    }
    else{
        CGRect frame21 = [_txt21 frame];
        CGRect frame22 = [_txt22 frame];
        CGRect frame23 = [_txt23 frame];
        CGRect frame24 = [_txt24 frame];
        
        CGRect frame31 = [_txt31 frame];
        CGRect frame32 = [_txt32 frame];
        CGRect frame33 = [_txt33 frame];
        CGRect frame34 = [_txt34 frame];
        
        CGRect frame41 = [_txt41 frame];
        CGRect frame42 = [_txt42 frame];
        CGRect frame43 = [_txt43 frame];
        CGRect frame44 = [_txt44 frame];
        
        
        frame21.origin.y -= 35;
        [_txt21 setFrame:frame21];
        frame22.origin.y -= 35;
        [_txt22 setFrame:frame22];
        frame23.origin.y -= 35;
        [_txt23 setFrame:frame23];
        frame24.origin.y -= 35;
        [_txt24 setFrame:frame24];
        
        frame31.origin.y -= 35;
        [_txt31 setFrame:frame31];
        frame32.origin.y -= 35;
        [_txt32 setFrame:frame32];
        frame33.origin.y -= 35;
        [_txt33 setFrame:frame33];
        frame34.origin.y -= 35;
        [_txt34 setFrame:frame34];
        
        frame41.origin.y -= 35;
        [_txt41 setFrame:frame41];
        frame42.origin.y -= 35;
        [_txt42 setFrame:frame42];
        frame43.origin.y -= 35;
        [_txt43 setFrame:frame43];
        frame44.origin.y -= 35;
        [_txt44 setFrame:frame44];
    }
    
}

-(void)costumizeFor3x3
{
    [self costumizeFor3x4];
    
    CGRect frame22 = [_btn22 frame];
    CGRect frame23 = [_btn23 frame];
    CGRect frame24 = [_btn24 frame];
    
    CGRect frame32 = [_btn32 frame];
    CGRect frame34 = [_btn34 frame];
    
    CGRect frame42 = [_btn42 frame];
    CGRect frame43 = [_btn43 frame];
    CGRect frame44 = [_btn44 frame];
    
    if ([self isiPad]){
        
        
        frame22.origin.x -= 30;
        [_btn22 setFrame:frame22];
        frame23.origin.x -= 30;
        [_btn23 setFrame:frame23];
        frame24.origin.x -= 30;
        [_btn24 setFrame:frame24];
        
        
        frame32.origin.x -= 30;
        [_btn32 setFrame:frame32];
        
        frame34.origin.x -= 30;
        [_btn34 setFrame:frame34];
        
        
        frame42.origin.x -= 30;
        [_btn42 setFrame:frame42];
        frame43.origin.x -= 30;
        [_btn43 setFrame:frame43];
        frame44.origin.x -= 30;
        [_btn44 setFrame:frame44];
        
    } else{
        frame22.origin.x -= 17;
        [_btn22 setFrame:frame22];
        frame23.origin.x -= 17;
        [_btn23 setFrame:frame23];
        frame24.origin.x -= 17;
        [_btn24 setFrame:frame24];
        
        frame32.origin.x -= 17;
        [_btn32 setFrame:frame32];
        
        frame34.origin.x -= 17;
        [_btn34 setFrame:frame34];
        
        
        frame42.origin.x -= 17;
        [_btn42 setFrame:frame42];
        frame43.origin.x -= 17;
        [_btn43 setFrame:frame43];
        frame44.origin.x -= 17;
        [_btn44 setFrame:frame44];
    }
    
    [self moveText3x3];
    
}

-(void)moveText3x3
{
    CGRect frame22 = [_txt22 frame];
    CGRect frame23 = [_txt23 frame];
    CGRect frame24 = [_txt24 frame];
    
    CGRect frame32 = [_txt32 frame];
    CGRect frame34 = [_txt34 frame];
    
    CGRect frame42 = [_txt42 frame];
    CGRect frame43 = [_txt43 frame];
    CGRect frame44 = [_txt44 frame];
    
    if ([self isiPad]){
        
        
        frame22.origin.x -= 30;
        [_txt22 setFrame:frame22];
        frame23.origin.x -= 30;
        [_txt23 setFrame:frame23];
        frame24.origin.x -= 30;
        [_txt24 setFrame:frame24];
        
        
        frame32.origin.x -= 30;
        [_txt32 setFrame:frame32];
        
        frame34.origin.x -= 30;
        [_txt34 setFrame:frame34];
        
        
        frame42.origin.x -= 30;
        [_txt42 setFrame:frame42];
        frame43.origin.x -= 30;
        [_txt43 setFrame:frame43];
        frame44.origin.x -= 30;
        [_txt44 setFrame:frame44];
        
    } else{
        frame22.origin.x -= 17;
        [_txt22 setFrame:frame22];
        frame23.origin.x -= 17;
        [_txt23 setFrame:frame23];
        frame24.origin.x -= 17;
        [_txt24 setFrame:frame24];
        
        frame32.origin.x -= 17;
        [_txt32 setFrame:frame32];
        
        frame34.origin.x -= 17;
        [_txt34 setFrame:frame34];
        
        
        frame42.origin.x -= 17;
        [_txt42 setFrame:frame42];
        frame43.origin.x -= 17;
        [_txt43 setFrame:frame43];
        frame44.origin.x -= 17;
        [_txt44 setFrame:frame44];
    }
}

@end

