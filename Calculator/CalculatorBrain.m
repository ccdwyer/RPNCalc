//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Christopher Dwyer on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;
- (NSMutableArray *) operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}


- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void)clearOperands
{
    while(YES)
    {
        NSNumber *operandObject = [self.operandStack lastObject];
        if (operandObject) [self.operandStack removeLastObject];
        else break;
    }
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        float top = [self popOperand];
        result = [self popOperand] - top;
    } else if ([operation isEqualToString:@"/"]) {
        float top = [self popOperand];
        //if (top != 0)
            result = [self popOperand] / top;
    } else if ([operation isEqualToString:@"Pi"]) {
        result = 3.14159265;
    } else if ([operation isEqualToString:@"Sin"]) {
        result = sin([self popOperand]); 
    } else if ([operation isEqualToString:@"Cos"]) {
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"Sqrt"]) {
        result = sqrt([self popOperand]);
    }
    
    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
}
@end
