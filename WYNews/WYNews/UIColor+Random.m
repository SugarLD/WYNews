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
    CGFloat f0 = arc4random_uniform(256) / 255.0;
    CGFloat f1 = arc4random_uniform(256) / 255.0;
    CGFloat f2 = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:f0 green:f1 blue:f2 alpha:1.0];
}

@end
