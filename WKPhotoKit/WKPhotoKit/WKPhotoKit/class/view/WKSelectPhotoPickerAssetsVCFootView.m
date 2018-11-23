//
//  WKSelectPhotoPickerAssetsVCFootViewCollectionReusableView.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/19.
//  Copyright © 2018 wk. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "WKSelectPhotoPickerAssetsVCFootView.h"
@interface WKSelectPhotoPickerAssetsVCFootView()
@property (strong, nonatomic) UILabel *footerLabel;
@end


@implementation WKSelectPhotoPickerAssetsVCFootView

- (void)prepareForReuse{
    [super prepareForReuse];
   
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.footerLabel];
        [self.footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
- (UILabel *)footerLabel{
    if (!_footerLabel) {
        UILabel *footerLabel = [[UILabel alloc] init];
        footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel = footerLabel;
    }
    return _footerLabel;
}

- (void)setCount:(NSInteger)count{
    _count = count;
    if (count >=0) {
        self.footerLabel.text = [NSString stringWithFormat:@"共有 %ld 张图片", (long)count];
    }
}
@end
