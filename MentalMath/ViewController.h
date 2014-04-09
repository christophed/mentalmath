//
//  ViewController.h
//  MentalMath
//
//  Created by Christophe Chong on 4/8/14.
//  Copyright (c) 2014 Christophe Chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (retain, nonatomic) IBOutlet UILabel *mathTitle;
@property (retain, nonatomic) IBOutlet UILabel *mathLabel;

typedef enum mathStateTypes
{
    START_STATE,
    GET_RANDOM_NUMBERS,
    SHOW_INTERMEDIATE_NUMBERS,
    DISPLAY_ANSWER
} MathState;

@end
