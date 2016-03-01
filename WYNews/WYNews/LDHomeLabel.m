//
//  LDHomeLabel.m
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHomeLabel.h"

#define kSmallFontSize 14
#define kBigFontSize 18

@implementation LDHomeLabel

+ (instancetype)homeLabelWithTitle:(NSString *)title {
    LDHomeLabel *label = [[LDHomeLabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    
    label.font = [UIFont systemFontOfSize:kBigFontSize];
    //尺寸
    [label sizeToFit];
    
    label.font = [UIFont systemFontOfSize:kSmallFontSize];
    //开启交互
    label.userInteractionEnabled = YES;
    
    return label;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    //文字从14号字体变成18号字体，增加的比例是：(18 - 14)/14
    CGFloat changeRate = (kBigFontSize - kSmallFontSize)/(CGFloat)kSmallFontSize;
    
    //文字根据控制器中collectionview的滚动逐渐缩小放大的最终比例
    CGFloat finalRate = changeRate * scale + 1;
    //LDLog(@"%f", scale);
    //label尺寸的缩放
    self.transform = CGAffineTransformMakeScale(finalRate, finalRate);
    
    //颜色渐变
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
}

//判断是否点击本label
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //传递点击事件
    if (self.selectedLabelBlock) {
        self.selectedLabelBlock();
    }
}

@end
