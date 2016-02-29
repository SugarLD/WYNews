//
//  LDHomeViewController.m
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHomeViewController.h"
#import "LDHomeChannelModel.h"
#import "LDHomeChannelViewModel.h"
#import "LDHomeLabel.h"
#import "LDChannelCell.h"

@interface LDHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *headScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homeLayout;

@property (strong, nonatomic) NSArray *channels;

@end
static NSString *ReuseIdentifier = @"ChannelCell";
@implementation LDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.collectionView registerClass:[LDChannelCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    
    //布局横幅
    [self setupHeadScrollview];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //布局collectionview
    [self setupHomeLayout];
}

#pragma  布局横幅
- (void)setupHeadScrollview {
    
    //scrollview遇到导航栏会自动偏移，取消偏移，才能看到scrollview中的内容
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化
    CGFloat homeLabelX = 5;
    CGFloat homeLabelY = 0;
    CGFloat homeLabelMargin = 5;
    CGFloat homeLabelHeight = self.headScrollView.frame.size.height;
    
    for (LDHomeChannelModel *channel in self.channels) {
        //创建label
        LDHomeLabel *homeLabel = [LDHomeLabel homeLabelWithTitle:channel.tname];
        //设置frame
        homeLabel.frame = CGRectMake(homeLabelX, homeLabelY, homeLabel.frame.size.width, homeLabelHeight);
        //添加
        [self.headScrollView addSubview:homeLabel];
        
        //更新值
        homeLabelX += homeLabelMargin + homeLabel.frame.size.width;
    }
    //设置scrollview的范围
    self.headScrollView.contentSize = CGSizeMake(homeLabelX, 0);
    self.headScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma 布局collectionview
- (void)setupHomeLayout {
    //横向滚动
    self.homeLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //尺寸
    self.homeLayout.itemSize = self.collectionView.bounds.size;
    self.homeLayout.minimumInteritemSpacing = 0;
    self.homeLayout.minimumLineSpacing = 0;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LDChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor randomColor];
    //数据
    LDHomeChannelModel *channelModel = self.channels[indexPath.item];
    cell.channelModel = channelModel;
    return cell;
}


#pragma mark --懒加载
- (NSArray *)channels {
    if (!_channels) {
        _channels = [LDHomeChannelViewModel homeChannels];
    }
    return _channels;
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
