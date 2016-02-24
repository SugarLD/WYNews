//
//  LDHeadViewModel.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHeadViewModel.h"
#import "LDHeadModel.h"

@implementation LDHeadViewModel

+ (void)headViewModelWithFinished:(void (^)(NSArray *, NSError *))finished {
    [[LDNetworkTool sharedNetworkTool] headViewWithSuccess:^(NSArray *results) {
        
        if (results.count == 0) {
            return ;
        }
        NSMutableArray *arrM = [NSMutableArray array];
        //遍历数组
        for (NSDictionary *dict in results) {
            LDHeadModel *headModel = [LDHeadModel headModelWithDict:dict];
            [arrM addObject:headModel];
            //LDLog(@"%@", headModel);
        }
        
        finished(arrM, nil);
        
    } failure:^(NSError *error) {
        finished(nil, error);
    }];
}

@end
