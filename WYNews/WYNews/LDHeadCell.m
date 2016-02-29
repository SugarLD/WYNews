//
//  LDHeadCell.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHeadCell.h"
#import "LDHeadModel.h"

@interface LDHeadCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end

@implementation LDHeadCell

- (void)setHeadModel:(LDHeadModel *)headModel {
    _headModel = headModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:headModel.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    
}

@end
