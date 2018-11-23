//
//  WKSelectPhotoPickerGroup.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKPhotoAsset.h"


@interface WKSelectPhotoPickerGroup : NSObject

/**
 *  组名
 */
@property(nonatomic,copy) NSString *groupName;

/**
 *  组的真实名
 */
@property(nonatomic,copy) NSString *realGroupName;

/**
 *  缩略图
 */
@property(nonatomic,strong) UIImage *thumbImage;

/**
 *  组里面的图片个数
 */
@property(nonatomic,assign) NSInteger assetsCount;

@property(nonatomic,strong)PHAssetCollection* group;

@property(nonatomic,strong)WKPhotoAsset* firstAsset;

@end


