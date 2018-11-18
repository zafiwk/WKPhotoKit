//
//  WKSelectPhoto.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKSelectPhotoAsset.h"
#import "WKSelectPhotoPickerData.h"
//图片对象
@implementation WKSelectPhotoAsset
- (NSString *)burstIdentifier{
    return self.asset.burstIdentifier;
}

-(void)showPhotoWithImageView:(UIImageView*)view withSize:(WKSelectPhotoSize)size{
    WKSelectPhotoPickerData* dataSource=[WKSelectPhotoPickerData defaultPicker];
    [dataSource getAssetsPhotoWithURLs:self.asset callBack:^(id  _Nonnull obj) {
        view.image = obj;
        
    } withSize:CGSizeMake(36, 36)];
}
@end
