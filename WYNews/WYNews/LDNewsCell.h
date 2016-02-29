//
//  LDNewsCell.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDNewsModel;
@interface LDNewsCell : UITableViewCell

@property (strong, nonatomic) LDNewsModel *newsModel;

//判断使用哪个重用标识
+ (NSString *)cellIdentifierWithNewsModel:(LDNewsModel *)newsModel;

//高度
+ (CGFloat)cellHeightWithNewsModel:(LDNewsModel *)newsModel;

@end
