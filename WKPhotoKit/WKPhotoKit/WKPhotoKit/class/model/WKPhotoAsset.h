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


@interface WKPhotoAsset : NSObject
@property (strong,nonatomic)PHAsset *asset;
/**
 获取图片的URL

 @return 返回图片URL的字符串
 */
-(NSString*)burstIdentifier;

@property(nonatomic)bool originalSize;

@end

NS_ASSUME_NONNULL_END
