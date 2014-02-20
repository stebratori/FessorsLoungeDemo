//
//  SkyFall.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

#import "SkyFall.h"
#import "UIView+Glow.h"
#import "Controller.h"
#import "Constants.h"


@interface SkyFall ()
@property BOOL gameFinished;
@property int x,y;
@property double cloudCreator;
@property int speed,speedLevelCounter, previousValue, newValue, game;
@property int cloudLevel1,cloudLevel2,cloudLevel3,cloudLevel4,cloudLevel5,cloudLevel6,cloudLevel7,cloudLevel8,cloudLevel9;
@property NSTimer *nsTimer, *speedTimer,*changeValueTimer,*glowValueTimer, *gameOverTimer;
@property int timeInterval,gameCounter;
@property CGRect cloud1rect, cloud2rect,cloud3rect, cloud4rect,cloud5rect,cloud6rect,cloud7rect,cloud8rect,cloud9rect;
@property int FIRST, SECOND, THIRD, FOURTH, FIRST_PAD, SECOND_PAD, THIRD_PAD, FOURTH_PAD;
@property UIImage *cloudRed, *cloudGreen;
@property CGFloat height;

@end

@implementation SkyFall

-(void)viewDidLoad
{
    
    self.buttonsArray = [self.buttonsArray mutableCopy];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self declareVariables];
    [self changeValue];
    [self threeErrors];
    
    
}

-(IBAction)startSkyfall:(UIStoryboardSegue *)sender{
    
}


-(void)createButton:(int)x y:(int)y withDelay:(int)delay
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonsArray addObject:button];
    [button addTarget:self
               action:nil
     forControlEvents:UIControlEventTouchDown];
    
    [self writeCloud:button];
    [button setBackgroundImage:[UIImage imageNamed:@"cloudWhite.png"] forState:UIControlStateNormal];
    [button setTintColor:[UIColor blackColor]];
    if (isiPhone5 || isiPhone){
        button.frame = CGRectMake(x, y, 90, 60);
        button.titleLabel.font = [UIFont systemFontOfSize:30];
    }else{
        button.frame = CGRectMake(x, y, 150, 100);
        button.titleLabel.font = [UIFont systemFontOfSize:50];
    }
    
    
    button.tag=0;
    
    [self.view addSubview:button];
    
    [self beginAnimationWithSpeed:_speed forButton:button withDelay:delay];
}

-(void)declareVariables
{
    [Constants shared].previousPlayedGame=1;
    _speed = 6;
    _cloudCreator = 1;
    _gameCounter = 5;
    _timeInterval = 60;
    _buttonsArray = [[NSMutableArray alloc]init];
    _gameFinished = NO;
    _speedLevelCounter = 0;
    _cloudLevel1 = 1;
    _cloudLevel2 = 1;
    _cloudLevel3 = 1;
    _cloudLevel4 = 1;
    _cloudLevel5 = 1;
    _cloudLevel6 = 1;
    _cloudLevel7 = 1;
    _cloudLevel8 = 1;
    _cloudLevel9 = 1;
    
    _cloudClicked1 = NO;
    _cloudClicked2 = NO;
    _cloudClicked3 = NO;
    _cloudClicked4 = NO;
    _cloudClicked5 = NO;
    _cloudClicked6 = NO;
    _cloudClicked7 = NO;
    _cloudClicked8 = NO;
    _cloudClicked9 = NO;
    _medalCounter = 0;
    _coinsInt = 0;
    _uncatchedCloudCounter = 0;
    _wrongAnswerCounter = 0;
    
    _nsTimer = [NSTimer scheduledTimerWithTimeInterval:_cloudCreator target:self selector:@selector(createCloud) userInfo:nil repeats:YES];
    _speedTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(adjustCloudSpeed) userInfo:Nil repeats:YES];
    _changeValueTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeValue) userInfo:Nil repeats:YES];
   // _glowValueTimer = [NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(glowValue) userInfo:nil repeats:YES];
    _FIRST = 50;
    _SECOND=125;
    _THIRD=193;
    _FOURTH=258;
    
    _FIRST_PAD = 198;
    _SECOND_PAD=350;
    _THIRD_PAD=512;
    _FOURTH_PAD=668;
    
    _cloudRed = [UIImage imageNamed:@"cloudRed.png"];
    _cloudGreen = [UIImage imageNamed:@"cloudGreen.png"];
    
    _height = [UIScreen mainScreen].bounds.size.height;
}

-(void)createCloud
{
    
    if (_gameFinished==YES){
        [_nsTimer invalidate];
        
        
    }else{
        
        
        if (isiPhone || isiPhone5){
            [self createFirst:_FIRST second:_SECOND third:_THIRD fourth:_FOURTH forY:-110];
        }
        else{
            [self createFirst:_FIRST_PAD second:_SECOND_PAD third:_THIRD_PAD fourth:_FOURTH_PAD forY:-140];
        }
    }
}

-(void)createFirst:(int)first second:(int)second third:(int)third fourth:(int)fourth forY:(int)y
{
    int random = 1 + arc4random() % (8-1);
    switch (random) {
        case 1:
            [self createButton:y y:first withDelay:0];
            break;
        case 5:
            [self createButton:y y:first withDelay:0];
            break;
            
        case 2:
            [self createButton:y y:second withDelay:0];
            break;
        case 6:
            [self createButton:y y:second withDelay:0];
            break;
            
        case 3:
            [self createButton:y y:third withDelay:0];
            break;
        case 7:
            [self createButton:y y:third withDelay:0];
            break;
            
        case 4:
            [self createButton:y y:fourth withDelay:0];
            break;
        case 8:
            [self createButton:y y:fourth withDelay:0];
            break;
    }

}

-(void)adjustCloudSpeed
{
    if(_speed>1.5){
        _speed-=0.5;
        if(_speed==3)
            _cloudCreator-=0.4f;
            if(_speed==2)
                _cloudCreator-=0.1f;
        
    }
}

-(void)beginAnimationWithSpeed:(int)speed forButton:(UIButton*)cloud withDelay:(int)delay
{
    
    
    [UIView animateWithDuration:speed
                          delay:delay
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
                     animations:^(void){
                         
                             cloud.frame = (CGRectMake(cloud.frame.origin.x+_height+110, cloud.frame.origin.y, cloud.frame.size.width, cloud.frame.size.height));
                     
                     }completion:^(BOOL finished){
                         if (finished){
                             
                             if(cloud.tag==0 ){
                                 if ([self checkAnswer:cloud]==YES){
                                     _uncatchedCloudCounter++;
                                     [self threeErrors];
                                 }
                             }
                             
                            [cloud removeFromSuperview];
                         }
                     }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    
    
    for (UIButton *button in _buttonsArray)
    {
        
        
        if ([button.layer.presentationLayer hitTest:touchLocation])
        {
            
            if (button.tag!=1){
            if ([self checkAnswer:button] == YES){
                
                
                [self trueAnswer:button];
                [button setBackgroundImage:_cloudGreen forState:UIControlStateNormal];
                button.tag=1;
            }
            else{
                [self falseAnswer:button];
                [button setBackgroundImage:_cloudRed forState:UIControlStateNormal];
                
                button.tag=1;
            }
            }
            
        }
    }
    
}

-(void)refreshCoins
{
    _coins.text = [NSString stringWithFormat:@"%d",_coinsInt];
}

-(void)trueAnswer:(UIButton*)button
{
    _coinsInt++;
    _coins.text = [NSString stringWithFormat:@"%d",_coinsInt];
}

-(void)falseAnswer:(UIButton*)button
{
    if (_coinsInt>0)
    _coinsInt--;
    _coins.text = [NSString stringWithFormat:@"%d",_coinsInt];
}

-(void)changeValue
{
    
        _speedLevelCounter++;
        _presentValue =[self setValueFrom:2 to:10];
        
        _targetValue.text = [NSString stringWithFormat:@"%d",_presentValue];
        
        _newValue = [self setValueFrom:2 to:10];
    
        while (_newValue == _presentValue) {
            _newValue = [self setValueFrom:2 to:10];
        }
        
        _previousValue = _presentValue;
    
        [_targetValue glowOnce];
    
    
}


-(void)threeErrors
{
    
    /*
     Tree errors is a game where a user will play untill he makes three errors, meaning he will let 3 clouds with the right andswer to fall down untouched.
     Medal will depend on the number of false answers.
     */
    _game = 0;
    
    _error1.hidden=NO;
    _error2.hidden=NO;
    _error3.hidden=NO;
    _clock.hidden=YES;
    _timer.hidden=YES;
    
    if (_uncatchedCloudCounter == 1){
        
        [ _error1 setImage:[UIImage imageNamed:@"wrong.png"]];
        [_error1 glowOnce];
    }
    
    if (_uncatchedCloudCounter == 2){
        
        [ _error2 setImage:[UIImage imageNamed:@"wrong.png"]];
        [_error2 glowOnce];
    }
    if (_uncatchedCloudCounter == 3){
        
        [ _error3 setImage:[UIImage imageNamed:@"wrong.png"]];
        [_error3 glowOnce];
        [self gameOver:_game];
    }
    
}



-(void)oneMinute
{
    /*
     One minute is a game where a user will play for exactly one minute.
     Right answers will grant points while all the wrong answers and untouched true clouds carry negative points.
     Medal will depend on the number of false answers.
     
     */
    _game = 1 ;
    _nsTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:Nil repeats:YES];
  
    _error1.hidden=YES;
    _error2.hidden=YES;
    _error3.hidden=YES;
    _clock.hidden = NO;
    _timer.hidden=NO;
}



-(void)countDown
{
    _timeInterval-=1;
    if (_timeInterval>9){
        _timer.text = [NSString stringWithFormat:@"00:%i",_timeInterval];
    }
    else{
        _timer.text = [NSString stringWithFormat:@"00:0%i",_timeInterval];
    }
    if (_timeInterval == 0){
        [_nsTimer invalidate];
        [self gameOver:1];
    }
}

-(void)writeCloud:(UIButton*)cloud
{
    NSString *equation = [self createEquation];
    [cloud setTitle: equation forState:UIControlStateNormal];
    
}

-(NSString*)createEquation
{
    
    // returns an equation string
    // it can be a true or false value
    // 20% chance to be true
    
    
    NSString *equation;
    
    
    
    // Randomize if it's going to be a true value or a random value
    int randomNumber = 1 + arc4random() % (4-1);
    // if true
    if (randomNumber == 2){
        equation = [[Controller shared] equationMaker:_presentValue forOperation:[Constants shared].presentOperation];
        
    }
    //if random
    else{
        equation = [[Controller shared] equationMaker:[self setValueFrom:2 to:10] forOperation:[Constants shared].presentOperation];
    }
    
    return equation;
    
}

-(int)setValueFrom:(int)from to:(int)to
{
    int randomNumber = from + arc4random() % (to-from);
    return randomNumber;
}

-(void)gameOver:(int)game
{
    [Constants shared].coins+=_coinsInt;
    [Constants shared].lastGameScore=_coinsInt;
    _gameFinished = YES;
    [_changeValueTimer invalidate];
    [_glowValueTimer invalidate];
    
    [_targetValue setFont:[UIFont systemFontOfSize:50]];
    
    if (game == 0){
        _targetValue.text = @"GAME OVER";
    }
    if (game == 1){
        _targetValue.text = @"TIME'S UP";
    }
    [_targetValue glowOnce];
    _gameOverTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(finishGame) userInfo:nil repeats:NO];
  
}

-(void)finishGame
{
    [self performSegueWithIdentifier:@"skyfall_done" sender:self];
}

-(BOOL)checkAnswer:(UIButton*)cloud
{
    BOOL returnValue = NO;
    NSString *cloudEquation =[cloud titleForState:UIControlStateNormal];
    int cloudResult = [[Controller shared] equationDecoder:cloudEquation];
    
    
    // true answer
    if (cloudResult == _presentValue){
        returnValue = YES;
        
    }
    //false answer
    else{
        returnValue = NO;
    }
    
    return returnValue;
    
    
}








@end
