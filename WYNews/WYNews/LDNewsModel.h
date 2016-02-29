//
//  LDNewsModel.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDNewsModel : NSObject
/**
 *  跟帖数
 */
@property (nonatomic, strong) NSNumber *replyCount;
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *imgsrc;
//http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html

@property (strong, nonatomic) NSArray *imgextra;

@property (nonatomic, assign) BOOL imgType;//是否是大图

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)newsModelWithDict:(NSDictionary *)dict;



@end
