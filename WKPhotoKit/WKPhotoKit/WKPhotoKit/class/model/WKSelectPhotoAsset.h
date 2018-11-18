//
//  WKSelectPhoto.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

typedef  NS_ENUM(NSInteger,WKSelectPhotoSize){
    WKSelectPhotoSizeOrigin,        //原图
    WKSelectPhotoSizeThumb ,        //缩略图
};
@interface WKSelectPhotoAsset : NSObject
@property (strong,nonatomic)PHAsset *asset;
/**
 获取图片的URL

 @return 返回图片URL的字符串
 */
-(NSString*)burstIdentifier;

/**
 在当前imageView展示图片

 @param view UIImageView对象
 */
-(void)showPhotoWithImageView:(UIImageView*)view withSize:(WKSelectPhotoSize)size;

@end

NS_ASSUME_NONNULL_END
