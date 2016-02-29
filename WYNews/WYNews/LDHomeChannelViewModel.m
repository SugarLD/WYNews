//
//  LDHomeChannelViewModel.m
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHomeChannelViewModel.h"
#import "LDHomeChannelModel.h"

@implementation LDHomeChannelViewModel

+ (NSArray *)homeChannels {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *jsonData= [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    //获取根节点
    NSString *keyRoot = dictionary.keyEnumerator.nextObject;
    NSArray *dictArr = dictionary[keyRoot];
    
    //遍历
    NSMutableArray *arrM = [NSMutableArray array];
    [dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LDHomeChannelModel *channel = [LDHomeChannelModel homeChannelModelWithDict:obj];
        [arrM addObject:channel];
    }];
    
    //排序
    return [arrM sortedArrayUsingComparator:^NSComparisonResult(LDHomeChannelModel * _Nonnull obj1, LDHomeChannelModel *  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
}

@end
