//
//  WKBrowserPhotoImageView.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKBrowserPhotoImageView.h"

@implementation WKBrowserPhotoImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        [self addGesture];
    }
    return self;
}


-(void)addGesture{
    //双击放大
    UITapGestureRecognizer* scaleBigTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleBigTapAction:)];
    scaleBigTap.numberOfTapsRequired = 2;
    scaleBigTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:scaleBigTap];
    
    
    //单击缩小
    UITapGestureRecognizer* scaleSmallTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleSmallTapAction:)];
    scaleSmallTap.numberOfTouchesRequired=1;
    scaleSmallTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:scaleSmallTap];
    
    [scaleSmallTap requireGestureRecognizerToFail:scaleBigTap];
}

-(void)scaleBigTapAction:(UITapGestureRecognizer*)tapGR{
    if ([self.delegate respondsToSelector:@selector(imageView:doubleTapDetected:)]) {
        [self.delegate imageView:self doubleTapDetected:tapGR];
    }
}

-(void)scaleSmallTapAction:(UITapGestureRecognizer*)tapGR{
    if([self.delegate respondsToSelector:@selector(imageView:singleTapDetected:)]){
        [self.delegate imageView:self singleTapDetected:tapGR];
    }
}
@end
