//
//  UIColor+Define.m
//  DictPublishAssistant
//
//  Created by zhuwei on 15/2/9.
//  Copyright (c) 2015年 zhuwei. All rights reserved.
//

#import "UIColor+Define.h"

@implementation UIColor (Define)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = cString.length >= 2 ? [cString substringWithRange:range] : @"FF";
    range.location = 2;
    NSString *gString = cString.length >= 4 ? [cString substringWithRange:range] : @"FF";
    range.location = 4;
    NSString *bString = cString.length >= 6 ? [cString substringWithRange:range] : @"FF";
    range.location = 6;
    NSString *aString = cString.length >= 8 ? [cString substringWithRange:range] : @"FF";
    
    unsigned int r, g, b,a;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}

@end
