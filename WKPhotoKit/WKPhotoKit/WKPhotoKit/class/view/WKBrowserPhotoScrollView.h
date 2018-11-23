//
//  WKBrowserPhotoScrollView.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKPhotoAsset.h"
#import "WKBrowserPhotoImageView.h"
#import "WKSelectPhotoPickerData.h"
@interface WKBrowserPhotoScrollView : UIScrollView
@property(nonatomic,strong)WKBrowserPhotoImageView* browserImage;
@end


