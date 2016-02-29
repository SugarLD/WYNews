//
//  LDChannelCell.m
//  WYNews
//
//  Created by pro on 16/2/28.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDChannelCell.h"
#import "LDNewsViewController.h"

@interface LDChannelCell ()

@property (strong, nonatomic) LDNewsViewController *newsVC;

@end

@implementation LDChannelCell

- (void)awakeFromNib {
    //加载sb
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //实例化控制器
    LDNewsViewController *newsVC = [sb instantiateInitialViewController];
    
    //添加
    [self.contentView addSubview:newsVC.view];
    self.newsVC = newsVC;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //布局
    self.newsVC.view.frame = self.bounds;
}

- (void)setChannelModel:(LDHomeChannelModel *)channelModel {
    _channelModel = channelModel;
    
    self.newsVC.channelModel = channelModel;
}


@end
