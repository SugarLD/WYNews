//
//  LDHomeLabel.h
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDHomeLabel : UILabel

+ (instancetype)homeLabelWithTitle:(NSString *)title;

/**
 *  缩放比例
 0 14号
 1 18号
 */
@property (assign, nonatomic) CGFloat scale;

//传递label的点击事件
@property (copy, nonatomic) void(^selectedLabelBlock)();


@end
