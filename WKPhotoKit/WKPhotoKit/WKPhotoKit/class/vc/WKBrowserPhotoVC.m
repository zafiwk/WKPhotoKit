//
//  WKBrowserPhotoCollectionVC.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKBrowserPhotoVC.h"
#import "WKBrowserPhotoCollectionVCCell.h"

@interface WKBrowserPhotoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,WKBrowserPhotoImageViewDelegate>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)UIButton* selectBtn;
@end

@implementation WKBrowserPhotoVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
   
    [self.collectionView scrollToItemAtIndexPath:self.selectIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    
    [self addItemBtn];
    [self  setupTop];
}

-(void)setupTop{
    WKPhotoAsset* asset=self.dataArray[self.selectIndexPath.row];
    [self setupTopBtn:asset];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld / %ld",self.selectIndexPath.row+1,self.dataArray.count];
}
-(void)addItemBtn{
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    btn.layer.masksToBounds=YES;
    self.selectBtn=btn;
    [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)loadView{
    [super loadView];
    CGRect frame=self.view.frame;
    frame.size.width = frame.size.width+20;
    self.view.frame= frame;
}
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize=self.view.bounds.size;
        flowLayout.headerReferenceSize=CGSizeZero;
        flowLayout.footerReferenceSize=CGSizeZero;
       flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing=0;
        flowLayout.minimumInteritemSpacing=0;
        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled= YES;
        _collectionView.dataSource=self;
        _collectionView.delegate= self;
        [_collectionView registerClass:[WKBrowserPhotoCollectionVCCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WKBrowserPhotoCollectionVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    WKPhotoAsset* asset=self.dataArray[indexPath.row];
    
    CGSize  assetSize=CGSizeMake(asset.asset.pixelWidth, asset.asset.pixelHeight);
    if(!asset.originalSize){
        CGFloat assetW=asset.asset.pixelWidth;
        CGFloat assetH=asset.asset.pixelHeight;
        CGSize  screenSize=self.view.bounds.size;
        if (assetW>=assetH&&assetW>=screenSize.width) {
            assetSize=CGSizeMake((NSInteger)screenSize.width, (NSInteger)assetH/assetW*screenSize.width);
        }
    
        if (assetH>assetW&&assetH>=screenSize.height) {
            assetSize=CGSizeMake((NSInteger)assetW/assetH*screenSize.height, (NSInteger)screenSize.height);
        }
    }
    WKSelectPhotoPickerData* picker=[WKSelectPhotoPickerData defaultPicker];
    [picker getAssetsPhotoWithPHAsset:asset callBack:^(id  _Nonnull obj) {
        cell.scrollView.browserImage.image = obj;
        if (asset.originalSize) {
            [cell setMaxZoom:assetSize];
        }else{
            [cell setMinZoom:assetSize];
        }
    } withSize:assetSize];

   

    cell.scrollView.browserImage.tag=indexPath.row*100;
    cell.scrollView.browserImage.delegate=self;
    return cell;
}
-(void)setupTopBtn:(WKPhotoAsset*)asset{
    if([self.selectDataArray indexOfObject:asset]==NSNotFound){
        NSString* iconImageNo=nil;
        CGFloat scale=[UIScreen mainScreen].scale;
        if (scale==2) {
            iconImageNo=@"icon_image_no@2x.png";
        }else{
            iconImageNo=@"icon_image_no@3x.png";
        }
        UIImage* image=[[UIImage imageNamed:iconImageNo] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.selectBtn setImage:image forState:UIControlStateNormal];
        
    }else{
        NSInteger assetSelectIndex=[self.selectDataArray indexOfObject:asset];
        NSString* str=[NSString stringWithFormat:@"%ld",assetSelectIndex+1];
        UILabel* titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.text=str;
        titleLable.layer.cornerRadius=12;
        titleLable.layer.masksToBounds=YES;
        titleLable.textAlignment=NSTextAlignmentCenter;
        UIImage* selectImage=nil;
        UIGraphicsBeginImageContext(CGSizeMake(24,24));
        [UIColorFromRGB(0x54b4ef) setFill];
        UIBezierPath* bezierPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 24, 24) cornerRadius:12];
        [bezierPath fill];
        [titleLable drawTextInRect:CGRectMake(0, 0, 24, 24)];
        selectImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.selectBtn setImage:selectImage forState:UIControlStateNormal];
    
    }
    
}
#pragma mark WKBrowserPhotoImageViewDelegate
- (void)imageView:(WKBrowserPhotoImageView *)imageView singleTapDetected:(UITapGestureRecognizer *)touch{

}
- (void)imageView:(WKBrowserPhotoImageView *)imageView doubleTapDetected:(UITapGestureRecognizer *)touch{
    NSInteger row=imageView.tag/100;
    WKPhotoAsset* asset=self.dataArray[row];
    asset.originalSize=!asset.originalSize;
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]]];
}


#pragma mark selectBtnClick
-(void)selectBtnClick:(UIButton*)btn{
    CGPoint point=self.collectionView.contentOffset;
    NSInteger row=(NSInteger)point.x/self.collectionView.bounds.size.width;;
    WKPhotoAsset* asset=self.dataArray[row];
    if ([self.selectDataArray indexOfObject:asset]==NSNotFound) {
        [self.selectDataArray addObject:asset];
    }else{
        [self.selectDataArray removeObject:asset];
    }
    [self setupTopBtn:asset];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        CGPoint point=scrollView.contentOffset;
        NSInteger currentIndex=(NSInteger)point.x/scrollView.bounds.size.width;
        self.navigationItem.title = [NSString stringWithFormat:@"%ld / %ld",currentIndex+1,self.dataArray.count];
        WKPhotoAsset* asset=self.dataArray[currentIndex];
        [self setupTopBtn:asset];
}
@end
