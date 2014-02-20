//
//  DragAndDrop.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 10/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "ViewController.h"
#import "Controller.h"

@interface DragAndDrop : ViewController

-(IBAction)startDragAndDrop:(UIStoryboardSegue *)sender;

@property (strong, nonatomic) IBOutlet UIButton *equation0;

@property (strong, nonatomic) IBOutlet UILabel *timer;
@property (strong, nonatomic) IBOutlet UILabel *points;

@property (strong, nonatomic) IBOutlet UIButton *result0;
@property (strong, nonatomic) IBOutlet UIButton *result1;
@property (strong, nonatomic) IBOutlet UIButton *result2;
@property (strong, nonatomic) IBOutlet UIButton *result3;
@property (strong, nonatomic) IBOutlet UIButton *result4;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;


@end
