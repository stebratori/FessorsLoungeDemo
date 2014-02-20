//
//  Lounge.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 13/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Lounge : UIViewController

//arrays of furniture

@property NSMutableArray* chairArray;

@property (strong, nonatomic) IBOutlet UIImageView *fessor;
@property (strong, nonatomic) IBOutlet UIImageView *chair;
@property (strong, nonatomic) IBOutlet UIImageView *table;
@property (strong, nonatomic) IBOutlet UIImageView *board;
@property (strong, nonatomic) IBOutlet UIImageView *picture;

@property (strong, nonatomic) IBOutlet UILabel *coins;

@property (strong, nonatomic) IBOutlet UIButton *btnGames;
@property (strong, nonatomic) IBOutlet UIButton *btnShop;
@property (strong, nonatomic) IBOutlet UIButton *btnVisit;

@property (strong, nonatomic) IBOutlet UIButton *btnMemoryGame;
@property (strong, nonatomic) IBOutlet UIButton *btnDragAndDrop;
@property (strong, nonatomic) IBOutlet UIButton *btnSkyfall;
@property (strong, nonatomic) IBOutlet UIButton *btnBoardGame;




//shop
@property (strong, nonatomic) IBOutlet UIButton *shopBuyBtn;
@property (strong, nonatomic) IBOutlet UIButton *shopLeftBtn;
@property (strong, nonatomic) IBOutlet UIButton *shopRightBtn;
@property (strong, nonatomic) IBOutlet UIButton *purchaceChair;
@property (strong, nonatomic) IBOutlet UILabel *itemCost;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *cloud;


-(IBAction)dropDownGames:(UIButton*)sender;

-(IBAction)goBack:(UIStoryboardSegue *)sender;

-(void)setTexture_forFessor:(int)fessor
                 forCarpet:(int)carpet
                  forChair:(int)chair
             forWallpapper:(int)wallpapper
                forPicture:(int)picture
                  forBoard:(int)board
                  forCombo:(int)combo;


-(IBAction)showPurchaceButtons:(UIButton*)sender;
-(IBAction)buySelectedItem:(UIButton*)sender;
-(IBAction)toggleItems:(UIButton*)sender;
-(IBAction)selectItem:(UIButton*)sender;

@end
