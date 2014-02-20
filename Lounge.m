//
//  Lounge.m
//  FessorsLounge
//
//  Created by Stefan Brankovic on 13/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import "Lounge.h"
#import "UIView+Glow.h"
#import "Constants.h"

@interface Lounge ()

@property int gameCount, shopCount,currentItemInArrayIndex, currentSelectedItem;
@property NSMutableArray* purchaceArray;
@end

@implementation Lounge



-(void)viewWillAppear:(BOOL)animated
{
   // [self setTexture_forFessor:2 forCarpet:1 forChair:1 forWallpapper:1 forPicture:1 forBoard:1 forCombo:1];
    _coins.text=[NSString stringWithFormat:@"%d",[Constants shared].coins];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self declareVariables];
    
    _coins.text=[NSString stringWithFormat:@"%d",[Constants shared].coins];
    
}

-(void)declareVariables
{
    _shopCount=0;
    _chairArray = [[NSMutableArray alloc]init];
    NSString* chair1=@"red_Sofa.png";
    NSString* chair2=@"yellow_Sofa.png";
    NSString* chair3=@"blue_Sofa.png";
    [_chairArray addObject:chair1];
    [_chairArray addObject:chair2];
    [_chairArray addObject:chair3];
    _currentItemInArrayIndex=0;
}

-(IBAction)goBack:(UIStoryboardSegue *)sender
{
    _coins.text=[NSString stringWithFormat:@"%d",[Constants shared].coins];
    _gameCount=0;
    _btnBoardGame.hidden=YES;
    _btnMemoryGame.hidden=YES;
    _btnSkyfall.hidden=YES;
    _btnDragAndDrop.hidden=YES;

}

-(void)setTexture_forFessor:(int)fessor
                  forCarpet:(int)carpet
                   forChair:(int)chair
              forWallpapper:(int)wallpapper
                 forPicture:(int)picture
                   forBoard:(int)board
                   forCombo:(int)combo
{
    
    switch (fessor) {
        case 1:
            [_fessor setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
            [_fessor setImage:[UIImage imageNamed:@"costumeViking.png"]];
            break;
            
    }
    
    switch (carpet) {
        case 1:
            //[_ setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
           // [_carpet setImage:[UIImage imageNamed:@"costumeViking.png"]];
            break;
            
    }
    
    switch (chair) {
        case 1:
            [_chair setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
            [_chair setImage:[UIImage imageNamed:@"costumeViking.png"]];
            break;
            
    }
    
    switch (wallpapper) {
        case 1:
            [_fessor setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
            [_fessor setImage:[UIImage imageNamed:@"costumeViking.png"]];
            break;
            
    }
    
    switch (picture) {
        case 1:
            [_picture setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
            [_picture setImage:[UIImage imageNamed:@"costumeViking.png"]];
            break;
            
    }
    
    switch (board) {
        case 1:
            [_board setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
            [_board setImage:[UIImage imageNamed:@"costumeViking.png"]];
        break;
    }
    
    switch (combo) {
        case 1:
            [_fessor setImage:[UIImage imageNamed:@"costumeFessor.png"]];
            break;
            
        case 2:
            [_fessor setImage:[UIImage imageNamed:@"costumeViking.png"]];
            break;
            
    }
    
    
    
    
}

-(IBAction)dropDownGames:(UIButton*)sender
{
    if (_gameCount == 0) {
        _btnBoardGame.hidden=NO;
        _btnMemoryGame.hidden=NO;
        _btnSkyfall.hidden=NO;
        _btnDragAndDrop.hidden=NO;
        _gameCount=1;
    }else{
        _btnBoardGame.hidden=YES;
        _btnMemoryGame.hidden=YES;
        _btnSkyfall.hidden=YES;
        _btnDragAndDrop.hidden=YES;
        _gameCount=0;
    }
}

-(IBAction)showPurchaceButtons:(UIButton*)sender
{
    if(_shopCount==0){
        _purchaceChair.hidden=NO;
        _shopCount=1;
        _btnGames.hidden=YES;
        _btnVisit.hidden=YES;
    }else{
        _purchaceChair.hidden=YES;
        _shopCount=0;
        _shopLeftBtn.hidden=YES;
        _shopRightBtn.hidden=YES;
        _shopBuyBtn.hidden=YES;
        _btnGames.hidden=NO;
        _btnVisit.hidden=NO;
        _cloud.hidden=YES;
        _itemCost.hidden=YES;
         _itemName.hidden=YES;
    }
}

-(IBAction)selectItem:(UIButton*)sender
{
    _purchaceArray = [[NSMutableArray alloc]initWithArray:_chairArray];
    
    _shopLeftBtn.hidden=NO;
    _shopRightBtn.hidden=NO;
    _shopBuyBtn.hidden=NO;
    _cloud.hidden=NO;
    _itemCost.hidden=NO;
    _itemName.hidden=NO;
    
    
    switch (sender.tag) {
        case 0:
            _currentItemInArrayIndex=0;
            _currentSelectedItem=0;
            break;
            
        default:
            break;
    }
}

-(IBAction)toggleItems:(UIButton *)sender
{
    switch (sender.tag) {
        
        case 0:
            if (_currentItemInArrayIndex+1 == _purchaceArray.count){
                _currentItemInArrayIndex=0;
            }else{
                _currentItemInArrayIndex++;
            }
            break;
            
        case 1:
            if (_currentItemInArrayIndex-1 <0){
                _currentItemInArrayIndex=_purchaceArray.count-1;
            }else{
                _currentItemInArrayIndex--;
            }
            break;
    }
    
    switch (_currentSelectedItem) {
        
        //chair
        case 0:
            [_chair setImage:[UIImage imageNamed:_chairArray[_currentItemInArrayIndex]]];
            // create an object "Item" with name,priced and locked.
           // You will need a database for these afterall
            break;
            
        default:
            break;
    }
}

-(IBAction)buySelectedItem:(UIButton*)sender
{
    
}


@end
