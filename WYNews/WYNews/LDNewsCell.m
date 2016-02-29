//
//  LDNewsCell.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDNewsCell.h"
#import "LDNewsModel.h"

@interface LDNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgviews;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@end

@implementation LDNewsCell

- (void)setNewsModel:(LDNewsModel *)newsModel {
    _newsModel = newsModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    
    self.titleLabel.text = newsModel.title;
    self.digestLabel.text = newsModel.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@人跟帖", newsModel.replyCount];
    
    [newsModel.imgextra enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imgStr = dict[@"imgsrc"];
        //获取imgview
        UIImageView *imgView = self.imgviews[idx];
        //赋值
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
        
    }];
    
}

+ (NSString *)cellIdentifierWithNewsModel:(LDNewsModel *)newsModel {
    if (newsModel.imgextra) {
        return @"ImageCell";
    }else if (newsModel.imgType){
        return @"BigCell";
    
    }else {
        return @"NewsCell";
    }
}

+ (CGFloat)cellHeightWithNewsModel:(LDNewsModel *)newsModel {
    if (newsModel.imgextra) {
        return 120;
    }else if (newsModel.imgType){
    
        return 150;
    }else {
        return 78;
    }
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
