//
//  WKBrowserPhotoImageView.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import <UIKit/UIKit.h>


@class  WKBrowserPhotoImageView;
@protocol WKBrowserPhotoImageViewDelegate <NSObject>

- (void)imageView:(WKBrowserPhotoImageView *)imageView singleTapDetected:(UITapGestureRecognizer *)touch;
- (void)imageView:(WKBrowserPhotoImageView *)imageView doubleTapDetected:(UITapGestureRecognizer *)touch;

@end

@interface WKBrowserPhotoImageView : UIImageView

@property(nonatomic,weak)id<WKBrowserPhotoImageViewDelegate> delegate;

@end

