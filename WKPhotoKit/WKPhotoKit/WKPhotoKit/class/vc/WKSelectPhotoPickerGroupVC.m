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
@interface WKSelectPhotoPickerGroupVC ()
@property(nonatomic,strong)NSArray<WKSelectPhotoPickerGroup *> * groups;
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
}

-(void)setupDataSource{
    WKSelectPhotoPickerData* dataSource=[WKSelectPhotoPickerData defaultPicker];
    self.groups=[dataSource getAllGroupWithPhotos];
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
    
    cell.groupName.text=[NSString stringWithFormat:@"%@(%ld)",group.groupName,group.assetsCount];
    WKSelectPhotoAsset* asset=group.firstAsset;
    [asset showPhotoWithImageView:cell.assetImage withSize:WKSelectPhotoSizeThumb];

    return cell;
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
