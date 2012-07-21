//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Christopher Dwyer on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userHasEnteredADecimalPoint;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize userHasEnteredADecimalPoint = _userHasEnteredADecimalPoint;
@synthesize brain = _brain;

-(CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
    self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    } else {
        self.display.text = sender.currentTitle;
        if (![sender.currentTitle isEqualToString:@"0"]) {
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
}
- (IBAction)decimalPointPressed {
    if (!self.userHasEnteredADecimalPoint) {
        if (!self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = @"0.";
            self.userIsInTheMiddleOfEnteringANumber = YES;
            self.userHasEnteredADecimalPoint = YES;
        } else {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.userIsInTheMiddleOfEnteringANumber = YES;
        self.userHasEnteredADecimalPoint = YES;
        }
    }
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasEnteredADecimalPoint = NO;
    //TODO: CLEAR HISTORY
    [self.brain clearOperands];
    self.history.text = @"";
}



- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasEnteredADecimalPoint = NO;
    self.history.text = [self.history.text stringByAppendingString:[@" " stringByAppendingString:self.display.text]];
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    [self.brain pushOperand:result];
    self.history.text = [self.history.text stringByAppendingString:[@" " stringByAppendingString:sender.currentTitle]];
}



- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
