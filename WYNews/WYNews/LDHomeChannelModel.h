//
//  LDHomeChannelModel.h
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDHomeChannelModel : NSObject

/**
 *  频道名称
 */
@property (nonatomic, copy) NSString *tname;

@property (nonatomic, copy) NSString *tid;

@property (copy, nonatomic) NSString *URLString;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)homeChannelModelWithDict:(NSDictionary *)dict;

@end
