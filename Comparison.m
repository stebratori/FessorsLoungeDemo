//
//  Comparison.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 19/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "Comparison.h"
#import "Constants.h"
#import "Controller.h"

@interface Comparison ()
@property CGRect btnLargerFrame,btnSmallerFrame,btnEqualFrame;
@property int firstValue, secondValue;
@end

@implementation Comparison

-(void)viewDidAppear:(BOOL)animated
{
    _btnLargerFrame = _btn_larger.frame;
    _btnSmallerFrame = _btn_smaller.frame;
    _btnEqualFrame = _btn_equal.frame;
}


-(void)declareVariables
{
    
}






-(IBAction)panSmaller:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    CGRect btn_smaller_rect = [_btn_smaller convertRect:_btn_smaller.frame toView:[_btn_smaller superview]];
    CGRect targetRect = [_symbol2 convertRect:_symbol2.frame toView:[_btn_smaller superview]];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (CGRectIntersectsRect(btn_smaller_rect, targetRect)){
            if([self checkComparison:1]){
                [_symbol2 setBackgroundColor:[UIColor greenColor]];
            }else{
                [_symbol2 setBackgroundColor:[UIColor redColor]];
            }
        }
        
        else{
            [self returnAnimation:_btn_smaller];
        }
    }
}

-(IBAction)panEqual:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    CGRect btn_equal_rect = [_btn_equal convertRect:_btn_equal.frame toView:[_btn_equal superview]];
    CGRect targetRect = [_symbol2 convertRect:_symbol2.frame toView:[_btn_equal superview]];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (CGRectIntersectsRect(btn_equal_rect, targetRect)){
            if([self checkComparison:2]){
                [_symbol2 setBackgroundColor:[UIColor greenColor]];
            }else{
                [_symbol2 setBackgroundColor:[UIColor redColor]];
            }        }
        
        else{
            [self returnAnimation:_btn_equal];
        }
    }
}

- (IBAction)panLarger:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    CGRect btn_larger_rect = [_btn_larger convertRect:_btn_larger.frame toView:[_btn_larger superview]];
    CGRect targetRect = [_symbol2 convertRect:_symbol2.frame toView:[_btn_larger superview]];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (CGRectIntersectsRect(btn_larger_rect, targetRect)){
            if([self checkComparison:3]){
                [_symbol2 setBackgroundColor:[UIColor greenColor]];
            }else{
                [_symbol2 setBackgroundColor:[UIColor redColor]];
            }
        }
        
        else{
            [self returnAnimation:_btn_larger];
        }
    }
}

  


-(void)returnAnimation:(UIButton*)button
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    switch (button.tag) {
        case 1:
            _btn_smaller.frame = _btnSmallerFrame;
            break;
            
        case 2:
            _btn_equal.frame = _btnEqualFrame;
            break;
            
        case 3:
            _btn_larger.frame = _btnLargerFrame;
            break;
    }
    
    [UIView commitAnimations];
    
}

-(BOOL)checkComparison:(int)sign
{
    BOOL returnBool = NO;
    
    _firstValue =   [[Controller shared]equationDecoder:_equation21.text];
    _secondValue =  [[Controller shared]equationDecoder:_equation22.text];
    
    
    switch (sign) {
        
        case 1:
            if (_firstValue < _secondValue)
                returnBool=YES;
            break;
            
        case 2:
            if (_firstValue == _secondValue)
                returnBool=YES;
            break;
            
        case 3:
            if (_firstValue > _secondValue)
                returnBool=YES;
            break;
    }
    return returnBool;
}



@end
