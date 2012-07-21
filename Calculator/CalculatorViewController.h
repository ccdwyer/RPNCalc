//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Christopher Dwyer on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *history;


- (IBAction)digitPressed:(id)sender;

@end
