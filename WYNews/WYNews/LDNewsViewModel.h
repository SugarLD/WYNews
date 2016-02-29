//
//  LDNewsViewModel.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDNewsViewModel : NSObject

+ (void)newsViewModelWithURLString:(NSString *)URLString Finshed:(void(^)(NSArray *newsModels, NSError *error))finished;

@end
