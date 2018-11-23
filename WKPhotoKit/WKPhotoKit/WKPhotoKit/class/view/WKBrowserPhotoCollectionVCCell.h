//
//  WKBrowserPhotoCollectionVCCell.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKPhotoAsset.h"
#import "WKBrowserPhotoScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WKBrowserPhotoCollectionVCCell : UICollectionViewCell
@property(nonatomic,strong)WKBrowserPhotoScrollView* scrollView;
-(void)setMinZoom:(CGSize)imageSize;
-(void)setMaxZoom:(CGSize)imageSize;
@end

NS_ASSUME_NONNULL_END
