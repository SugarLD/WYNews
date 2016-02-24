//
//  LDHeadModel.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHeadModel.h"

@implementation LDHeadModel


+ (instancetype)headModelWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
    
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
