//
//  LDNetworkTool.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface LDNetworkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;


- (void)headViewWithSuccess:(void(^)(NSArray *results))success failure:(void(^)(NSError *error))failure;

@end
