//
//  LDNewsViewModel.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDNewsViewModel.h"
#import "LDNetworkTool.h"
#import "LDNewsModel.h"

@implementation LDNewsViewModel

+ (void)newsViewModelWithURLString:(NSString *)URLString Finshed:(void(^)(NSArray *newsModels, NSError *error))finished {
    
    [[LDNetworkTool sharedNetworkTool] newsWithURLString:URLString Success:^(NSArray *results) {
        
        if (results.count == 0) {
            return ;
        }
        NSMutableArray *arrM = [NSMutableArray array];
        //遍历
        for (NSDictionary *dict in results) {
            LDNewsModel *newsModel = [LDNewsModel newsModelWithDict:dict];
            [arrM addObject:newsModel];
        }
        
        finished(arrM, nil);
        
    } failure:^(NSError *error) {
        finished(nil, error);
    }];
}

@end
