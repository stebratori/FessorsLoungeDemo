//
//  DragAndDrop.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "DragAndDrop.h"
#import "Constants.h"


#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE

@interface DragAndDrop ()

@property int equationValue, timeInterval, pointsInt;
@property NSString* value0, *value1, *value2, *value3, *value4, *equation;
@property CGRect buttonFrame;
@property NSTimer* nsTimer;
@property NSTimer* gameOverTimer;

@end

@implementation DragAndDrop

-(void)viewDidLoad
{
   [Constants shared].previousPlayedGame=2;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self generateEquationFrom:2 to:10];
    [self declareVariables];
}



-(void)viewDidAppear:(BOOL)animated
{
    _buttonFrame = _equation0.frame;
}

-(void)declareVariables
{
    _timeInterval=40;
    _nsTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:Nil repeats:YES];
    _pointsInt=0;
}

-(IBAction)startDragAndDrop:(UIStoryboardSegue *)sender{
    
}
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer

{
    
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    CGRect equationRect = [_equation0 convertRect:_equation0.frame toView:[_equation0 superview]];
    
    CGRect targetRect1 = [_result0 convertRect:_result0.frame toView:[_equation0 superview]];
    CGRect targetRect2 = [_result1 convertRect:_result1.frame toView:[_equation0 superview]];
    CGRect targetRect3 = [_result2 convertRect:_result2.frame toView:[_equation0 superview]];
    CGRect targetRect4 = [_result3 convertRect:_result3.frame toView:[_equation0 superview]];
    CGRect targetRect5 = [_result4 convertRect:_result4.frame toView:[_equation0 superview]];
    
    int value1 = [[_result0 titleForState:UIControlStateNormal] intValue];
    int value2 = [[_result1 titleForState:UIControlStateNormal] intValue];
    int value3 = [[_result2 titleForState:UIControlStateNormal] intValue];
    int value4 = [[_result3 titleForState:UIControlStateNormal] intValue];
    int value5 = [[_result4 titleForState:UIControlStateNormal] intValue];
    
    
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (( CGRectIntersectsRect(equationRect, targetRect1) ) ||
            ( CGRectIntersectsRect(equationRect, targetRect2) ) ||
            ( CGRectIntersectsRect(equationRect, targetRect3) ) ||
            ( CGRectIntersectsRect(equationRect, targetRect4) ) ||
            ( CGRectIntersectsRect(equationRect, targetRect5)  ))
        {
            
            if (CGRectIntersectsRect(equationRect, targetRect1) ) {
                if (value1 == _equationValue){
                    [self matchedAnimation];
                }else{
                    [self returnAnimation];
                }
            }
            
            if (CGRectIntersectsRect(equationRect, targetRect2) ) {
                if (value2 == _equationValue){
                    [self matchedAnimation];
                }else{
                    [self returnAnimation];
                }
            }
            if (CGRectIntersectsRect(equationRect, targetRect3) ) {
                if (value3 == _equationValue){
                    [self matchedAnimation];
                }else{
                    [self returnAnimation];
                }
            }
            if (CGRectIntersectsRect(equationRect, targetRect4)  ){
                if (value4 == _equationValue){
                    [self matchedAnimation];
                }else{
                    [self returnAnimation];
                }
            }
            if (CGRectIntersectsRect(equationRect, targetRect5)  ){
                if (value5 == _equationValue){
                    [self matchedAnimation];
                }else{
                    [self returnAnimation];
                }
            }
            
            
            
        }else{
            [self returnAnimation];
        }
    }
    
    
    
    
}




-(void)generateEquationFrom:(int)from to:(int)to
{
    int result = from + arc4random() % (to-from);
    
    _equation = [[Controller shared] equationMaker:result forOperation:0];
    _equationValue = result;
    [_equation0 setTitle:_equation forState:UIControlStateNormal];
    
    _value0 = [NSString stringWithFormat:@"%d",result];
    _value1 = [[Controller shared] generateRandom:result fromValue:2 toValue:10];
    _value2 = [[Controller shared] generateRandom:result differentFrom:[_value1 intValue] fromValue:2 toValue:10];
    _value3 = [[Controller shared] generateRandom:result differentFrom:[_value1 intValue] andDifferentFrom:[_value2 intValue] fromValue:2 toValue:10];
    _value4 = [[Controller shared] generateRandom:result differentFrom:[_value1 intValue] andDifferentFrom:[_value2 intValue] andDifferentFrom:[_value3 intValue] fromValue:2 toValue:10];
    
    
    
    int random = 1 + arc4random() % (5-1);
    switch (random) {
            
        case 1:
            [_result0 setTitle:_value0 forState:UIControlStateNormal];
            [_result1 setTitle:_value1 forState:UIControlStateNormal];
            [_result2 setTitle:_value2 forState:UIControlStateNormal];
            [_result3 setTitle:_value3 forState:UIControlStateNormal];
            [_result4 setTitle:_value4 forState:UIControlStateNormal];
            break;
            
        case 2:
            [_result0 setTitle:_value1 forState:UIControlStateNormal];
            [_result1 setTitle:_value0 forState:UIControlStateNormal];
            [_result2 setTitle:_value2 forState:UIControlStateNormal];
            [_result3 setTitle:_value3 forState:UIControlStateNormal];
            [_result4 setTitle:_value4 forState:UIControlStateNormal];
            break;
            
        case 3:
            [_result0 setTitle:_value2 forState:UIControlStateNormal];
            [_result1 setTitle:_value1 forState:UIControlStateNormal];
            [_result2 setTitle:_value0 forState:UIControlStateNormal];
            [_result3 setTitle:_value3 forState:UIControlStateNormal];
            [_result4 setTitle:_value4 forState:UIControlStateNormal];
            break;
            
        case 4:
            [_result0 setTitle:_value3 forState:UIControlStateNormal];
            [_result1 setTitle:_value1 forState:UIControlStateNormal];
            [_result2 setTitle:_value2 forState:UIControlStateNormal];
            [_result3 setTitle:_value0 forState:UIControlStateNormal];
            [_result4 setTitle:_value4 forState:UIControlStateNormal];
            break;
            
        case 5:
            [_result0 setTitle:_value4 forState:UIControlStateNormal];
            [_result1 setTitle:_value1 forState:UIControlStateNormal];
            [_result2 setTitle:_value2 forState:UIControlStateNormal];
            [_result3 setTitle:_value3 forState:UIControlStateNormal];
            [_result4 setTitle:_value0 forState:UIControlStateNormal];
            break;
    }
    
    
}



-(void)returnAnimation
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    _equation0.frame = _buttonFrame;
    
    [UIView commitAnimations];
    
}

-(void)matchedAnimation
{
    _equation0.alpha=0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    _equation0.frame = _buttonFrame;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:0.5];
    _equation0.alpha=1;
    [UIView commitAnimations];
    
    [self generateEquationFrom:2 to:10];
    _pointsInt++;
    _points.text = [NSString stringWithFormat:@"Points: %d",_pointsInt];
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
        _gameOverTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gameOver) userInfo:nil repeats:NO];
    }
}

-(void)gameOver
{
    [Constants shared].previousPlayedGame=2;
    [Constants shared].lastGameScore=_pointsInt;
    [Constants shared].coins = _pointsInt/3;
    [self performSegueWithIdentifier:@"drag_and_drop_done" sender:self];
}


@end
