//
//  UIColor+Random.m
//  QQZoneUniversal
//
//  Created by pro on 16/2/18.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor {
    CGFloat f = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:f green:f blue:f alpha:1.0];
}

@end
