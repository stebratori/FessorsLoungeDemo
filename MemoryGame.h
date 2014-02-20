//
//  MemoryGame.h
//  FessorsLounge
//
//  Created by Stefan Brankovic on 11/02/14.
//  Copyright (c) 2014 EduLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoryGame : UIViewController

-(IBAction)startMemoryGame:(UIStoryboardSegue *)sender;

@property (weak, nonatomic) IBOutlet UILabel *memoryGameCoins;
@property (weak, nonatomic) IBOutlet UIImageView *memoryGameMedal;

@property (weak, nonatomic) IBOutlet UIImageView *memoryGame;

@property (weak, nonatomic) IBOutlet UIButton *btn11;
@property (weak, nonatomic) IBOutlet UIButton *btn12;
@property (weak, nonatomic) IBOutlet UIButton *btn13;
@property (weak, nonatomic) IBOutlet UIButton *btn14;

@property (weak, nonatomic) IBOutlet UIButton *btn21;
@property (weak, nonatomic) IBOutlet UIButton *btn22;
@property (weak, nonatomic) IBOutlet UIButton *btn23;
@property (weak, nonatomic) IBOutlet UIButton *btn24;

@property (weak, nonatomic) IBOutlet UIButton *btn31;
@property (weak, nonatomic) IBOutlet UIButton *btn32;
@property (weak, nonatomic) IBOutlet UIButton *btn33;
@property (weak, nonatomic) IBOutlet UIButton *btn34;

@property (weak, nonatomic) IBOutlet UIButton *btn41;
@property (weak, nonatomic) IBOutlet UIButton *btn42;
@property (weak, nonatomic) IBOutlet UIButton *btn43;
@property (weak, nonatomic) IBOutlet UIButton *btn44;

//@property (strong, nonatomic) IBOutlet UIView *bonusContainer;

@property (weak, nonatomic) IBOutlet UILabel *txt11;
@property (weak, nonatomic) IBOutlet UILabel *txt12;
@property (weak, nonatomic) IBOutlet UILabel *txt13;
@property (weak, nonatomic) IBOutlet UILabel *txt14;

@property (weak, nonatomic) IBOutlet UILabel *txt21;
@property (weak, nonatomic) IBOutlet UILabel *txt22;
@property (weak, nonatomic) IBOutlet UILabel *txt23;
@property (weak, nonatomic) IBOutlet UILabel *txt24;

@property (weak, nonatomic) IBOutlet UILabel *txt31;
@property (weak, nonatomic) IBOutlet UILabel *txt32;
@property (weak, nonatomic) IBOutlet UILabel *txt33;
@property (weak, nonatomic) IBOutlet UILabel *txt34;

@property (weak, nonatomic) IBOutlet UILabel *txt41;
@property (weak, nonatomic) IBOutlet UILabel *txt42;
@property (weak, nonatomic) IBOutlet UILabel *txt43;
@property (weak, nonatomic) IBOutlet UILabel *txt44;


@property int currentTime;


@property (weak, nonatomic) IBOutlet UIImageView *fessor;




@property UIImage *iceland;
@property UIImage *faroe;
@property UIImage *norway;
@property UIImage *denmark;
@property UIImage *sweden;
@property UIImage *finland;
@property UIImage *white_button;

@property UIImage *icelandBck;
@property UIImage *faroeBck;
@property UIImage *norwayBck;
@property UIImage *denmarkBck;
@property UIImage *swedenBck;
@property UIImage *finlandBck;

@property UIImage *gold;
@property UIImage *silver;
@property UIImage *bronze;

@property int memoryGameSize;
@property int score;
@property int bonus;
@property int medalCounter;
@property int counter;
@property int bonusCounter;

@property int firstValue;
@property int secondValue;
@property int result;

@property NSString* stringValue;


-(IBAction)controller:(UIButton*)sender;

@property UIButton* btnClicked1;
@property UIButton* btnClicked2;

@property UILabel* txtClicked1;
@property UILabel* txtClicked2;

@property (weak, nonatomic) IBOutlet UILabel *labelClicked;

@property UIImage *regular;
@property UIImage *hero;
@property UIImage *cowboy;
@property UIImage *indian;
@property UIImage *pirate;
@property UIImage *viking;


@property BOOL revealed11;
@property BOOL revealed12;
@property BOOL revealed13;
@property BOOL revealed14;

@property BOOL revealed21;
@property BOOL revealed22;
@property BOOL revealed23;
@property BOOL revealed24;

@property BOOL revealed31;
@property BOOL revealed32;
@property BOOL revealed33;
@property BOOL revealed34;

@property BOOL revealed41;
@property BOOL revealed42;
@property BOOL revealed43;
@property BOOL revealed44;




// BONUS
-(IBAction)cloudClick :(UIButton*)sender;

@property (strong, nonatomic) IBOutlet UIImageView *bonusBck;
@property (strong, nonatomic) IBOutlet UIImageView *bonusFessor;
@property (strong, nonatomic) IBOutlet UILabel *bonusLabel;
@property (strong, nonatomic) IBOutlet UIButton *cloud1;
@property (strong, nonatomic) IBOutlet UIButton *cloud2;
@property (strong, nonatomic) IBOutlet UIButton *cloud3;
@property (strong, nonatomic) IBOutlet UIImageView *bonusClock;
@property (strong, nonatomic) IBOutlet UILabel *timer;

@property BOOL bonusTriggered;



@property UIImage *greenCloud;
@property UIImage *whiteCloud;
@property UIImage *redCloud;

@property int equationInt;
@end
