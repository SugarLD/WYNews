//
//  LDHeadViewController.m
//  WYNews
//
//  Created by pro on 16/2/24.
//  Copyright © 2016年 LeeDan. All rights reserved.
//

#import "LDHeadViewController.h"
#import "LDHeadCell.h"
#import "LDHeadViewModel.h"
#import "LDHeadModel.h"

@interface LDHeadViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *headLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//head数据数组
@property (strong, nonatomic) NSArray *headModels;

@end

@implementation LDHeadViewController

static NSString * const reuseIdentifier = @"HeadCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    //[self setupLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //发送请求
    [self loadHeadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupLayout];//布局
}

- (void)setupLayout {
    self.headLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.headLayout.itemSize = self.collectionView.bounds.size;
    self.headLayout.minimumLineSpacing = 0;
    
    
    self.collectionView.pagingEnabled = YES;
}

- (void)loadHeadData {
    [LDHeadViewModel headViewModelWithFinished:^(NSArray *headModels, NSError *error) {
        if (error != nil || headModels.count == 0) {
            return ;
        }
      
        self.headModels = headModels;
        [self.collectionView reloadData];
        //显示最中间的那一组
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:500] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
    }];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1000;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.headModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LDHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //LDLog(@"%zd", indexPath.item);
    //设置cell的tag
    cell.tag = indexPath.item;
    
    //获取模型
    LDHeadModel *headModel = self.headModels[indexPath.item];
    // Configure the cell
    cell.headModel = headModel;
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = (scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5) / scrollView.bounds.size.width;
    //LDLog(@"%zd", page % self.headModels.count);
    page %= self.headModels.count;
    //获取模型
    LDHeadModel *headModel = self.headModels[page];
    self.titleLabel.text = headModel.title;
    self.pageControl.currentPage = page;

}

#pragma mark --懒加载
- (NSArray *)headModels {
    if (!_headModels) {
        _headModels = [NSArray array];
       
    }
    return _headModels;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
