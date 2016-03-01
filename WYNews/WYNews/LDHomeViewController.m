//
//  LDHomeViewController.m
//  WYNews
//
//  Created by pro on 16/2/25.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHomeViewController.h"
#import "LDNewsViewController.h"

#import "LDHomeChannelModel.h"
#import "LDHomeChannelViewModel.h"
#import "LDHomeLabel.h"
#import "LDChannelCell.h"

@interface LDHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *headScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homeLayout;

@property (strong, nonatomic) NSArray *channels;
@property (assign, nonatomic) NSInteger currentIndex;

//控制器缓存池
@property (strong, nonatomic) NSMutableDictionary *VCCache;

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
    
    NSInteger index = 0;
    for (LDHomeChannelModel *channel in self.channels) {
        //创建label
        LDHomeLabel *homeLabel = [LDHomeLabel homeLabelWithTitle:channel.tname];
        
        //设置tag
        homeLabel.tag = index;
        //索引自增
        index++;
        
        //label点击事件传递
        __weak typeof(self) weakSelf = self;
        __weak typeof(homeLabel) weakHomeLabel = homeLabel;
        homeLabel.selectedLabelBlock = ^{
            
            if (weakHomeLabel.tag == weakSelf.currentIndex) return ;
            
            //先将当前选中的label恢复原样
            LDHomeLabel *currentLabel = weakSelf.headScrollView.subviews[weakSelf.currentIndex];
            
            //更新选中label
            currentLabel.scale = 0.0;
            weakHomeLabel.scale = 1.0;
            
            
            //更新：滚动collectionview到相应的cell
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:weakHomeLabel.tag inSection:0];
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            
            //更新
            weakSelf.currentIndex = weakHomeLabel.tag;
            
            //根据当前选中的标签计算scrollview的偏移值
            //LDLog(@"%f", weakHomeLabel.center.x);
            CGFloat offset = weakHomeLabel.center.x - weakSelf.headScrollView.bounds.size.width * 0.5;
            //计算最大的偏移值
            CGFloat maxOffset = weakSelf.headScrollView.contentSize.width - weakSelf.headScrollView.bounds.size.width;
            if (offset < 0) {
                offset = 0;
            }
            if (offset > maxOffset) {
                offset = maxOffset;
            }
            
            [weakSelf.headScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
            
        };
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
    
    //默认选择第一个
    self.currentIndex = 0;
    LDHomeLabel *defaultLabel = self.headScrollView.subviews[self.currentIndex];
    defaultLabel.scale = 1.0;
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
    
    //数据
    LDHomeChannelModel *channelModel = self.channels[indexPath.item];
    
    //移除已有的控制器view
    if (cell.newsVC.view) {
        [cell.newsVC.view removeFromSuperview];
    }
    
    //需要防止数据重复加载
    cell.newsVC = [self newsViewController:channelModel];
    
    return cell;
}

- (LDNewsViewController *)newsViewController: (LDHomeChannelModel *)channelModel{
    //先从缓存池中获取
    LDNewsViewController *newsVC = [self.VCCache objectForKey:channelModel.tid];
    if (newsVC == nil) {
        //没有值，创建
        //加载sb
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //实例化控制器
        newsVC = [sb instantiateInitialViewController];
        //赋值
        newsVC.channelModel = channelModel;
        
        //存储
        [self.VCCache setValue:newsVC forKey:channelModel.tid];
    }
    // 一定要有下面代码，否则会打断响应者链条
    // 如果一个控制器A的view是控制器B的view的子控件,那么控制器A必须是控制器B的子控制器。
    // 控制器的view互为父子关系，则控制器必须也互为父子关系
    if (![self.childViewControllers containsObject:newsVC]) {
        [self addChildViewController:newsVC];
    }
    return newsVC;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取当前cell对应的label
    LDHomeLabel *currentLabel = self.headScrollView.subviews[self.currentIndex];
    
    //获取下个cell的索引
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    
    //遍历
    LDHomeLabel *nextLabel = nil;
    for (NSIndexPath *path in indexPaths) {
        if (path.item != self.currentIndex) {
            //下个标签
            nextLabel = self.headScrollView.subviews[path.item];
            break;
        }
    }
    //如果不判断，文字的尺寸会出现错乱
    if (nextLabel == nil) {
        return;
    }
    //计算下一个cell进入屏幕的比例
    CGFloat nextScale = ABS(scrollView.contentOffset.x / scrollView.bounds.size.width - self.currentIndex);
    //计算当前cell在当前屏幕占据的比例
    CGFloat currentScale = 1 - nextScale;
    
    //计算label的显示尺寸和文字颜色
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //滚动结束时，更新当前索引
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
}


#pragma mark --懒加载
- (NSArray *)channels {
    if (!_channels) {
        _channels = [LDHomeChannelViewModel homeChannels];
    }
    return _channels;
}

- (NSMutableDictionary *)VCCache {
    if (!_VCCache) {
        _VCCache = [NSMutableDictionary dictionary];
    }
    return _VCCache;
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
