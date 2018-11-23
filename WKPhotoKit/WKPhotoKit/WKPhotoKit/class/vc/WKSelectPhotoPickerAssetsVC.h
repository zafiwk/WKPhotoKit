//
//  WKSelectPhotoPickerAssetsVC.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKSelectPhotoPickerGroup.h"
#import "WKSelectPhotoPickerGroupVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface WKSelectPhotoPickerAssetsVC : UIViewController
@property(nonatomic,strong)WKSelectPhotoPickerGroup* group;
@property(nonatomic,strong)selectImagesBlock block;
@property(nonatomic,strong)NSMutableArray* selectPhotoDataArray;
@end

NS_ASSUME_NONNULL_END
