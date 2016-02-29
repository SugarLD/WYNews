//
//  LDHomeChannelModel.m
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHomeChannelModel.h"

@implementation LDHomeChannelModel

+ (instancetype)homeChannelModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;

}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setTid:(NSString *)tid {
    _tid = tid;
    
    _URLString = [NSString stringWithFormat:@"article/headline/%@/0-140.html", tid];
}

@end
