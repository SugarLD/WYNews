//
//  LDHomeLabel.m
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHomeLabel.h"

@implementation LDHomeLabel

+ (instancetype)homeLabelWithTitle:(NSString *)title {
    LDHomeLabel *label = [[LDHomeLabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    
    label.font = [UIFont systemFontOfSize:15];
    //尺寸
    [label sizeToFit];
    
    label.font = [UIFont systemFontOfSize:13];
    
    
    return label;
}

@end
