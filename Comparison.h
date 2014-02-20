//
//  Comparison.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 19/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Comparison : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btn_smaller;
@property (strong, nonatomic) IBOutlet UIButton *btn_equal;
@property (strong, nonatomic) IBOutlet UIButton *btn_larger;

@property (strong, nonatomic) IBOutlet UILabel *equation21;
@property (strong, nonatomic) IBOutlet UILabel *equation22;

@property (strong, nonatomic) IBOutlet UIImageView *symbol2;



- (IBAction)panLarger:(UIPanGestureRecognizer *)recognizer;
- (IBAction)panSmaller:(UIPanGestureRecognizer *)recognizer;
- (IBAction)panEqual:(UIPanGestureRecognizer *)recognizer;



@end
