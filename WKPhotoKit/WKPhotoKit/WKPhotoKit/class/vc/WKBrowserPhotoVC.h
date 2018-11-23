//
//  WKBrowserPhotoCollectionVC.h
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/21.
//  Copyright © 2018 wk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface WKBrowserPhotoVC : UIViewController
@property(nonatomic,strong)NSArray* dataArray;
@property(nonatomic,strong)NSMutableArray* selectDataArray;
@property(nonatomic,strong)NSIndexPath* selectIndexPath;
@end

NS_ASSUME_NONNULL_END
