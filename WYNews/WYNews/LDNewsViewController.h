//
//  LDNewsViewController.h
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDHomeChannelModel;
@interface LDNewsViewController : UITableViewController
@property (strong, nonatomic) LDHomeChannelModel *channelModel;
@end
