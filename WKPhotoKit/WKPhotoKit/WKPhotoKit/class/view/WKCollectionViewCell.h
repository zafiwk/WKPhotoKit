//
//  WKCollectionViewCell.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WKCollectionViewCellDelegate <NSObject>
-(void)photoSelectBtnClick:(UIButton*)btn;
@end
@interface WKCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *assetImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property(weak,nonatomic)id<WKCollectionViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
