//
//  LDNewsViewController.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDNewsViewController.h"

#import "LDNewsCell.h"

#import "LDNewsModel.h"
#import "LDNewsViewModel.h"
#import "LDHomeChannelModel.h"

@interface LDNewsViewController ()

@property (strong, nonatomic) NSArray *newsModels;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation LDNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
    
}

- (void)setChannelModel:(LDHomeChannelModel *)channelModel {
    _channelModel = channelModel;
    //加载数据
    [self loadNewsData];
}

- (void)loadNewsData {
    [LDNewsViewModel newsViewModelWithURLString:self.channelModel.URLString Finshed:^(NSArray *newsModels, NSError *error) {
        if (error != nil || newsModels.count == 0) {
            return ;
        }
        
        self.newsModels = newsModels;
        [self.tableView reloadData];
    }];
}


#pragma mark -- 懒加载
- (NSArray *)newsModels {
    if (!_newsModels) {
        _newsModels = [NSArray array];
    }
    return _newsModels;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取模型
    LDNewsModel *newsModel = self.newsModels[indexPath.row];
    
    LDNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[LDNewsCell cellIdentifierWithNewsModel:newsModel]];
    
    
    cell.newsModel = newsModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取模型
    LDNewsModel *newsModel = self.newsModels[indexPath.row];
    return [LDNewsCell cellHeightWithNewsModel:newsModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
