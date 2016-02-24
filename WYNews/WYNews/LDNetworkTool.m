//
//  LDNetworkTool.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDNetworkTool.h"

static LDNetworkTool *instance = nil;
@implementation LDNetworkTool

+ (instancetype)sharedNetworkTool {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 15;
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (void)headViewWithSuccess:(void(^)(NSArray *results))success failure:(void(^)(NSError *error))failure {
    [self GET:@"ad/headline/0-4.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //LDLog(@"%@", responseObject);
        //success(responseObject[@"headline_ad"]);
        //获得第一个key
        NSString *rootKey = [responseObject keyEnumerator].nextObject;
        success(responseObject[rootKey]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"LDNetworkTool-error: %@", error);
        failure(error);
    }];
}

@end
