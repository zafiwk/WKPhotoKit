//
//  WKCollectionViewCell.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKCollectionViewCell.h"
@interface WKCollectionViewCell()



@end
@implementation WKCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.activityView stopAnimating];
    
    [self.selectBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    self.selectBtn.layer.masksToBounds=YES;
    self.selectBtn.layer.cornerRadius=12;
    
}
- (IBAction)selectBtnClick:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(photoSelectBtnClick:)]){
        [self.delegate photoSelectBtnClick:sender];
    }
}

@end
