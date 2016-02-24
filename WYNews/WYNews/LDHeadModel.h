//
//  LDHeadModel.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDHeadModel : NSObject

@property (copy, nonatomic) NSString *imgsrc;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)headModelWithDict:(NSDictionary *)dict;

@end
