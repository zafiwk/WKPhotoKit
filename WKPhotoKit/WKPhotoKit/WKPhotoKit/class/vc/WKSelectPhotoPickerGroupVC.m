//
//  WKSelectPhotoPickerGroupVC.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKSelectPhotoPickerGroupVC.h"
#import "WKSelectPhotoPickerGroup.h"
#import "WKSelectPhotoPickerData.h"
#import "WKSelectPhotoPickerGroupVCCellTableViewCell.h"
#import "WKSelectPhotoPickerAssetsVC.h"
@interface WKSelectPhotoPickerGroupVC ()
@property(nonatomic,strong)NSArray<WKSelectPhotoPickerGroup *> * groups;
@property(nonatomic,strong)NSMutableArray* selectPhotoDataArray;
@end

@implementation WKSelectPhotoPickerGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
    
    [self setupDataSource];
    
    [self setupTableView];
}
-(void)setupTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"WKSelectPhotoPickerGroupVCCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight=60;
    self.title= @"相册";
}

-(void)setupDataSource{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status==PHAuthorizationStatusDenied) {
        UIAlertController* alertVC=[UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开相册权限" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    if (status == PHAuthorizationStatusNotDetermined||status == PHAuthorizationStatusRestricted) {
        // 这里便是无访问权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status==PHAuthorizationStatusAuthorized){
                WKSelectPhotoPickerData* dataSource=[WKSelectPhotoPickerData defaultPicker];
                self.groups=[dataSource getAllGroupWithPhotos];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }else{
        WKSelectPhotoPickerData* dataSource=[WKSelectPhotoPickerData defaultPicker];
        self.groups=[dataSource getAllGroupWithPhotos];
    }
}


- (void)setupButtons{
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = barItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKSelectPhotoPickerGroupVCCellTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WKSelectPhotoPickerGroup* group = self.groups[indexPath.row];
    
    cell.groupName.text=[NSString stringWithFormat:@"%@(%ld)",[self  transformAblumTitle:group.groupName],group.assetsCount];
    WKPhotoAsset* asset=group.firstAsset;
    
    WKSelectPhotoPickerData* photoPicker=[WKSelectPhotoPickerData defaultPicker];
    [photoPicker  getAssetsPhotoWithPHAsset:asset callBack:^(id  _Nonnull obj) {
        cell.assetImage.image=obj;
    } withSize:cell.assetImage.bounds.size];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WKSelectPhotoPickerAssetsVC* vc=[[WKSelectPhotoPickerAssetsVC alloc]init];
    WKSelectPhotoPickerGroup* group = self.groups[indexPath.row];
    vc.group=group;
    vc.selectPhotoDataArray=self.selectPhotoDataArray;
    vc.title=[self  transformAblumTitle:group.groupName];
    vc.block = self.block;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray*)selectPhotoDataArray{
    if (!_selectPhotoDataArray) {
        _selectPhotoDataArray=[NSMutableArray array];
    }
    return _selectPhotoDataArray;
}
#pragma mark 相册名字本地化

- (NSString *)transformAblumTitle:(NSString *)title{
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    } else if ([title isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    } else if ([title isEqualToString:@"Favorites"]) {
        return @"最爱";
    } else if ([title isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    } else if ([title isEqualToString:@"Videos"]) {
        return @"视频";
    } else if ([title isEqualToString:@"All Photos"]) {
        return @"所有照片";
    } else if ([title isEqualToString:@"Selfies"]) {
        return @"自拍";
    } else if ([title isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    } else if ([title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    return title;
}


-(void)dealloc{
    NSLog(@"WKSelectPhotoPickerGroupVC层销毁");
}
@end
