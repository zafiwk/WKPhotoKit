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
 * 获取所有组对应的Videos
 */
-(NSArray<WKSelectPhotoPickerGroup*>*)getAllGroupWithVideos;

/**
 *  传入一个PHAsset来获取UIImage
 */
- (void) getAssetsPhotoWithURLs:(PHAsset *) asset callBack:(callBackBlock ) callBack withSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
