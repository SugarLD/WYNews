//
//  LDHeadViewModel.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDHeadViewModel : NSObject

+ (void)headViewModelWithFinished:(void(^)(NSArray *headModels, NSError *error))finished;

@end
