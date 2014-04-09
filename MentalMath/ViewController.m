//
//  ViewController.m
//  MentalMath
//
//  Created by Christophe Chong on 4/8/14.
//  Copyright (c) 2014 Christophe Chong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain, nonatomic) NSNumber *first;
@property (retain, nonatomic) NSNumber *second;
@property (retain, nonatomic) NSDate *startTime;

@end

MathState state = GET_RANDOM_NUMBERS;

@implementation ViewController

@synthesize first=_first;
@synthesize second=_second;
@synthesize startTime=_startTime;

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // handling code
        [self advanceState];
        [self renderState];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(handleTap:)];

    [self.view addGestureRecognizer:tapRecognizer];

    state = START_STATE;
}

- (void)presentNewProblem
{
    
}

- (void)advanceState
{
    switch (state) {
        case START_STATE:
            state = GET_RANDOM_NUMBERS;
            [self setRandomProducts];
            [self setTimer];
            break;
        case GET_RANDOM_NUMBERS:
            state = SHOW_INTERMEDIATE_NUMBERS;
            break;
        case SHOW_INTERMEDIATE_NUMBERS:
            state = DISPLAY_ANSWER;
            break;
        case DISPLAY_ANSWER:
            state = START_STATE;
            [self resetProducts];
            break;
        default:
            break;
    }
}

- (void)setTimer
{
    [self setStartTime:[NSDate date]];
}

- (void)setRandomProducts
{
    [self setFirst:[NSNumber numberWithInt:1 + arc4random() % 100]];
    [self setSecond: [NSNumber numberWithInt:1 + arc4random() % 100]];

}

- (void)resetProducts
{
}

- (void)renderState
{
    switch (state) {
        case START_STATE:
            [_mathTitle setText:@"Tap for a challenge"];
            [_mathLabel setText:@""];
            break;
        case GET_RANDOM_NUMBERS:
            [_mathTitle setText:@"Tap for the intermediate answers"];
            [_mathLabel setText:[NSString stringWithFormat:@"%@ x %@", _first, _second]];
            break;
        case SHOW_INTERMEDIATE_NUMBERS:
            [_mathTitle setText:@"Intermediate answers (tap for answer)"];
            [_mathLabel setText:[self intermediateString]];
            break;
        case DISPLAY_ANSWER:
            NSLog(@"Display answer");
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:[self startTime]];

            double timeToCompletion = interval;
            
            [_mathTitle setText:[NSString stringWithFormat:@"Answer in %f seconds", timeToCompletion]];

            [_mathLabel setText:[self finalAnswer]];
            break;
        default:
            break;
    }
}

- (NSString*)intermediateString
{
    int first_ones = [_first intValue] % 10;
    int first_tens = [_first intValue] / 10 * 10;
    
    int second_ones = [_second intValue] % 10;
    int second_tens = [_second intValue] / 10 * 10;
    
    return [NSString stringWithFormat:@"(%d + %d) x (%d + %d)", first_tens, first_ones, second_tens, second_ones];
}

- (NSString*)finalAnswer
{
    return [NSString stringWithFormat:@"%d", ([_first intValue] * [_second intValue])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mathLabel release];
    [_mathTitle release];
    [super dealloc];
}
@end
