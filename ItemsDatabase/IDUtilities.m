//
//  IDUtilities.m
//  ItemsDatabase
//
//  Created by ignacio mariani on 4/7/17.
//  Copyright © 2017 ignacio mariani. All rights reserved.
//

#import "IDUtilities.h"

@implementation IDUtilities

+ (NSString *)formatDecimalFromFloat:(float)resFloat
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 5;
    
    NSString *result = [formatter stringFromNumber:@(resFloat)];
    
    return result;
}

@end
