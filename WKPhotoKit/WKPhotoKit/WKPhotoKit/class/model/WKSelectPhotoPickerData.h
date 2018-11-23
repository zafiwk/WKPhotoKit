//
//  WKSelectPhotoPickerData.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKSelectPhotoPickerGroup.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^callBackBlock)(id obj);

@interface WKSelectPhotoPickerData : NSObject
/**
 *  获取所有组
 */
+(instancetype)defaultPicker;

/**
 * 获取所有组对应的图片
 */
-(NSArray<WKSelectPhotoPickerGroup*>*)getAllGroupWithPhotos;

/**
 *  传入一个PHAsset来获取UIImage
 */
- (void)getAssetsPhotoWithPHAsset:(WKPhotoAsset*) asset callBack:(callBackBlock ) callBack withSize:(CGSize)size;

/**
 *  取消获取图片
 */
-(void)stopGetAssets:(PHImageRequestID)requestId;

/**
 *  传入一个组获取组里面的Asset
 */
- (NSArray<WKPhotoAsset*>*) getGroupPhotosWithGroup : (WKSelectPhotoPickerGroup *) pickerGroup;


/**
 *缓存某张图片
 */
-(void)cachingImage:(WKPhotoAsset*)asset;
/**
 *
 */
-(void)stopCaching:(WKPhotoAsset*)asset;
@end

NS_ASSUME_NONNULL_END
