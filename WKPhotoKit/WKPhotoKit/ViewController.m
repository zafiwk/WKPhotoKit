//
//  ViewController.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wangkang. All rights reserved.
//

#import "ViewController.h"
#import "WKSelectPhotoPickerGroupVC.h"
#import "WKCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)NSArray<UIImage*> * images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem* right=[[UIBarButtonItem alloc]initWithTitle:@"选择图片" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    self.navigationItem.rightBarButtonItem =right;
    
    [self.view addSubview:self.collectionView];
    
}

-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=2;
        layout.minimumInteritemSpacing=2;
        CGFloat cellWidth=([UIScreen mainScreen].bounds.size.width-2*3)/4.0;
        layout.itemSize=CGSizeMake(cellWidth, cellWidth);
        layout.footerReferenceSize=CGSizeMake(self.view.bounds.size.width, 30);
        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor] ;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerNib:[UINib nibWithNibName:@"WKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
    }
    return  _collectionView;
}


#pragma mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.assetImageView.image=self.images[indexPath.row];
   
    
    return cell;
}

-(void)rightClick{
    WKSelectPhotoPickerGroupVC* vc=[[WKSelectPhotoPickerGroupVC alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController* naviC=[[UINavigationController alloc]initWithRootViewController:vc];
    __weak typeof(self) weakSelf = self;
    vc.block = ^(NSArray * _Nonnull array) {
        weakSelf.images= array;
        [weakSelf.collectionView reloadData];
    };
    [self presentViewController:naviC animated:YES completion:nil];
}

@end
