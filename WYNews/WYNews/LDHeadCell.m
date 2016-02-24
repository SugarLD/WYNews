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
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation LDHeadCell

- (void)setHeadModel:(LDHeadModel *)headModel {
    _headModel = headModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:headModel.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.titleLabel.text = headModel.title;
    
    self.pageControl.currentPage = self.tag;
    LDLog(@"tag: %zd, currentPage: %zd", self.tag, self.pageControl.currentPage);
}

@end
