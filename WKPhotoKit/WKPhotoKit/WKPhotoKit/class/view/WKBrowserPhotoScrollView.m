//
//  WKBrowserPhotoScrollView.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKBrowserPhotoScrollView.h"
#import <Masonry/Masonry.h>
@interface WKBrowserPhotoScrollView()<WKBrowserPhotoImageViewDelegate,UIScrollViewDelegate>


@end
@implementation WKBrowserPhotoScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.browserImage=[[WKBrowserPhotoImageView alloc]init];
        self.browserImage.delegate =self;
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.browserImage];
        self.backgroundColor = [UIColor blackColor];
        self.delegate =self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
- (void)imageView:(WKBrowserPhotoImageView *)imageView singleTapDetected:(UITapGestureRecognizer *)touch{
    
}
- (void)imageView:(WKBrowserPhotoImageView *)imageView doubleTapDetected:(UITapGestureRecognizer *)touch{
    
}


-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  self.browserImage;
}
@end
