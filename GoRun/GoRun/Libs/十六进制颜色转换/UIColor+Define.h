//
//  UIColor+Define.h
//  DictPublishAssistant
//
//  Created by zhuwei on 15/2/9.
//  Copyright (c) 2015年 zhuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


@interface UIColor (Define)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
