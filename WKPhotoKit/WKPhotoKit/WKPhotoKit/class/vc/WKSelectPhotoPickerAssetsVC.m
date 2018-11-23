//
//  WKSelectPhotoPickerAssetsVC.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//


#import "WKSelectPhotoPickerAssetsVC.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "WKCollectionViewCell.h"
#import "WKSelectPhotoPickerData.h"
#import "WKSelectPhotoPickerAssetsVCFootView.h"
#import "WKBrowserPhotoVC.h"
#define CELL_V_SPACE  2
#define CELL_H_SPACE  2
@interface WKSelectPhotoPickerAssetsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,WKCollectionViewCellDelegate>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)UILabel* makeLabel;
@property(nonatomic,strong)UIToolbar* toolbar;

@property(nonatomic,strong)NSArray<WKPhotoAsset*>* dataArray;
@property(nonatomic,strong)NSMutableArray<UIImage*>* imageArray;
@property(nonatomic,strong)MBProgressHUD* hud;
@end

@implementation WKSelectPhotoPickerAssetsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupToorbar];
    
    [self setupPhotoView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    self.makeLabel.text=[NSString stringWithFormat:@"%ld",self.selectPhotoDataArray.count];
}
-(void)setupToorbar{
    UIToolbar* toorBar=[[UIToolbar alloc]init];
    [self.view addSubview:toorBar];
    [toorBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    
    UIBarButtonItem* fiexItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* rightItem=[[UIBarButtonItem alloc]initWithCustomView:[self  doneBtn]];
    toorBar.items=@[fiexItem,rightItem];
    
    self.toolbar=toorBar;
}

-(void)setupPhotoView{
    [self.view addSubview:self.collectionView];
    __weak  typeof(self) weakSelf= self;
    CGRect navigationBarFrame=self.navigationController.navigationBar.frame;
    CGFloat safeValue= CGRectGetMaxY(navigationBarFrame);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(weakSelf.toolbar.mas_top).offset(0);
        make.top.mas_equalTo(weakSelf.view).offset(safeValue);
    }];
  
    WKSelectPhotoPickerData* picker=[WKSelectPhotoPickerData defaultPicker];
    self.dataArray=[picker getGroupPhotosWithGroup:self.group];
    [self.view bringSubviewToFront:self.toolbar];
    
}
-(UIButton*)doneBtn{
    UIButton* doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    doneBtn.frame=CGRectMake(0, 0, 44, 44);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn addSubview:self.makeLabel];
    return doneBtn;
}

-(UILabel*)makeLabel{
    if (!_makeLabel) {
        UILabel* makeLabel=[[UILabel alloc]init];
        makeLabel.textColor = [UIColor whiteColor];
        makeLabel.textAlignment=NSTextAlignmentCenter;
        makeLabel.font=[UIFont systemFontOfSize:13];
        makeLabel.frame=CGRectMake(-5, -5, 20, 20);
        makeLabel.hidden=YES;
        makeLabel.layer.cornerRadius=makeLabel.frame.size.height/2.0;
        makeLabel.clipsToBounds=YES;
        makeLabel.backgroundColor=[UIColor redColor];
        _makeLabel=makeLabel;
    }
    return _makeLabel;
}
-(NSMutableArray*)imageArray{
    if (!_imageArray) {
        _imageArray=[NSMutableArray array];
    }
    return _imageArray;
}
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=CELL_H_SPACE;
        layout.minimumInteritemSpacing=CELL_V_SPACE;
        CGFloat cellWidth=([UIScreen mainScreen].bounds.size.width-CELL_H_SPACE*3)/4.0;
        layout.itemSize=CGSizeMake(cellWidth, cellWidth);
        layout.footerReferenceSize=CGSizeMake(self.view.bounds.size.width, 30);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor] ;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerNib:[UINib nibWithNibName:@"WKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[WKSelectPhotoPickerAssetsVCFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
        
    }
    return  _collectionView;
}

#pragma mark doneBtnClick
-(void)doneBtnClick{
    [self.hud showAnimated:YES];
    if(self.selectPhotoDataArray.count==0){
        [self.hud hideAnimated:YES];
        self.block(self.imageArray);
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    WKPhotoAsset* asset=[self.selectPhotoDataArray  firstObject];
    WKSelectPhotoPickerData* pick=[WKSelectPhotoPickerData defaultPicker];
    [pick getAssetsPhotoWithPHAsset:asset callBack:^(id  _Nonnull obj) {
        [self.imageArray addObject:obj];
        [self.selectPhotoDataArray removeObject:asset];
        [self doneBtnClick];
    } withSize:CGSizeMake(asset.asset.pixelWidth, asset.asset.pixelHeight)];
    
}

#pragma mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.group.assetsCount;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WKPhotoAsset* asset=self.dataArray[indexPath.row];
    CGFloat cellWidth=([UIScreen mainScreen].bounds.size.width-CELL_H_SPACE*3)/4.0;
    WKSelectPhotoPickerData* picker=[WKSelectPhotoPickerData defaultPicker];
    [picker getAssetsPhotoWithPHAsset:asset callBack:^(id  _Nonnull obj) {
        cell.assetImageView.image=obj;
    } withSize:CGSizeMake(cellWidth, cellWidth)];
    cell.selectBtn.tag=indexPath.row*100;
    cell.delegate = self;
    if ([self.selectPhotoDataArray  indexOfObject:asset]==NSNotFound) {
        NSString* iconImageNo=nil;
        CGFloat scale=[UIScreen mainScreen].scale;
        if (scale==2) {
            iconImageNo=@"icon_image_no@2x.png";
        }else{
            iconImageNo=@"icon_image_no@3x.png";
        }
        
        UIImage* image=[[UIImage imageNamed:iconImageNo] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [cell.selectBtn setBackgroundImage:image forState:UIControlStateNormal];
        [cell.selectBtn setTitle:nil forState:UIControlStateNormal];
        cell.selectBtn.backgroundColor = [UIColor clearColor];
    }else{
        [cell.selectBtn setBackgroundImage:nil forState:UIControlStateNormal];
        cell.selectBtn.backgroundColor = UIColorFromRGB(0x54b4ef);
        NSInteger assetSelectIndex=[self.selectPhotoDataArray indexOfObject:asset];
        [cell.selectBtn setTitle:[NSString stringWithFormat:@"%ld",assetSelectIndex+1] forState:UIControlStateNormal];
    }
    
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WKSelectPhotoPickerAssetsVCFootView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        WKSelectPhotoPickerAssetsVCFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.count = self.dataArray.count;
        reusableView = footerView;

    }else{
        
    }
    return reusableView;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    WKBrowserPhotoVC* vc=[[WKBrowserPhotoVC alloc]init];
    vc.dataArray =self.dataArray;
    vc.selectDataArray =self.selectPhotoDataArray;
    vc.selectIndexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark WKCollectionViewCellDelegate
-(void)photoSelectBtnClick:(UIButton*)btn{
    NSInteger row=btn.tag/100;
    WKPhotoAsset* asset=self.dataArray[row];
    NSIndexPath* indexPath=[NSIndexPath indexPathForRow:row inSection:0];
    WKSelectPhotoPickerData* picker=[WKSelectPhotoPickerData defaultPicker];
    WKCollectionViewCell* cell=(WKCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    if ([self.selectPhotoDataArray  indexOfObject:asset]==NSNotFound) {
        [self.selectPhotoDataArray addObject:asset];
        cell.activityView.hidden=NO;
        [cell.activityView startAnimating];
        [picker cachingImage:asset];
    }else{
        [self.selectPhotoDataArray removeObject:asset];
        [picker stopCaching:asset];
    }
    
    if(self.selectPhotoDataArray.count==0){
        self.makeLabel.hidden=YES;
    }else{
        self.makeLabel.text=[NSString stringWithFormat:@"%ld",self.selectPhotoDataArray.count];
        self.makeLabel.hidden=NO;
    }
    [self.collectionView reloadData];
}

-(MBProgressHUD*)hud{
    if (!_hud) {
        _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode =MBProgressHUDModeText;
        _hud.label.text=@"图片获取中";
        _hud.removeFromSuperViewOnHide=YES;
        
        
    }
    return _hud;
}
@end
