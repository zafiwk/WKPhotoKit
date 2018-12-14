//
//  WKBrowserPhotoCollectionVCCell.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKBrowserPhotoCollectionVCCell.h"
#import <Masonry/Masonry.h>
@interface WKBrowserPhotoCollectionVCCell()

@end
@implementation WKBrowserPhotoCollectionVCCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.scrollView=[[WKBrowserPhotoScrollView alloc]init];
        [self.contentView addSubview:self.scrollView];
        
        CGFloat scrollViewWidth=self.contentView.bounds.size.width-20;
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(scrollViewWidth);
        }];
    }
    return self;
}
-(void)setMinZoom:(CGSize)imageSize{
    CGRect imageRect=CGRectZero;
    imageRect.size=imageSize;
    CGRect  screenRect=[UIScreen mainScreen].bounds;
    CGFloat xValue=(screenRect.size.width -imageSize.width)/2.0;
    CGFloat yValue=(screenRect.size.height-imageSize.height)/2.0;
    imageRect.origin=CGPointMake(xValue, yValue);
    self.scrollView.browserImage.frame=imageRect;
    self.scrollView.contentSize=imageSize;
}
-(void)setMaxZoom:(CGSize)imageSize{
    CGRect imageRect=CGRectZero;
    imageRect.size=imageSize;
    self.scrollView.browserImage.frame=imageRect;
    self.scrollView.contentSize=imageSize;
}
@end
