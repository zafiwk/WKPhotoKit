//
//  WKSelectPhotoPickerData.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wk. All rights reserved.
//

#import "WKSelectPhotoPickerData.h"

@implementation WKSelectPhotoPickerData
+ (instancetype) defaultPicker{
        return  [[WKSelectPhotoPickerData alloc]init];
}

-(NSArray<WKSelectPhotoPickerGroup*>*)getAllGroupWithPhotos{
    return [self getAllGroupWithPhotos:NO];
}
/**
 遍历相册的时候是否获取相册

 @param allPhotos 是否获取所有图片
 @return 返回相片组
 */
-(NSArray<WKSelectPhotoPickerGroup*>*)getAllGroupWithPhotos:(BOOL)allPhotos{
    NSMutableArray *groups = [NSMutableArray array];
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (int i=0; i<smartAlbums.count; i++) {
        PHCollection *collection = smartAlbums[i];
        NSMutableArray* imageList=[self  fetchResultWith:collection withPhotos:allPhotos];
        if (allPhotos) {
            [groups addObject:imageList];
        }else{
            if(imageList.count>0){
                [groups addObject:[imageList firstObject]];
            }
        }
    }
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for(int i=0;i<topLevelUserCollections.count;i++){
        PHCollection *collection =topLevelUserCollections[i];
        NSMutableArray* imageList=[self  fetchResultWith:collection withPhotos:allPhotos];
        if (allPhotos) {
            [groups addObject:imageList];
        }else{
            if(imageList.count>0){
                [groups addObject:[imageList firstObject]];
            }
        }
        
    }
    return groups;
}
/**
 递归遍历集合

 @param colletion 传入一个集合
 @return 返回是图片还是相册
 */
-(NSMutableArray*)fetchResultWith:(PHCollection*)colletion withPhotos:(BOOL)allPhotos{
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    NSMutableArray* dataList=[NSMutableArray array];
    if ([colletion isKindOfClass:[PHAssetCollection class]]) {
        PHAssetCollection *assetCollection = (PHAssetCollection *)colletion;
        if (!allPhotos) {
            
            NSMutableArray* imageList=[self fetchResultWith:assetCollection withPhotos:YES];
            if(imageList.count>0){
                WKSelectPhotoPickerGroup* photoGroup=[[WKSelectPhotoPickerGroup alloc]init];
                photoGroup.group=assetCollection;
                photoGroup.groupName=assetCollection.localizedTitle;
                photoGroup.assetsCount=imageList.count;
                WKSelectPhotoAsset* photoAssets=[imageList firstObject];
                photoGroup.firstAsset=photoAssets;
                [dataList addObject:photoGroup];
            }
        }else{
            // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
            for (int i=0; i<fetchResult.count; i++) {
                NSMutableArray* subList=[self fetchResultWith:fetchResult[i] withPhotos:allPhotos];
                [dataList addObjectsFromArray:subList];
            }
        }
    }else {
        PHAsset* asset=(PHAsset*)colletion;
        if (allPhotos&&asset.mediaType==PHAssetMediaTypeImage) {
            WKSelectPhotoAsset* photoAssets=[[WKSelectPhotoAsset alloc]init];
            photoAssets.asset=asset;
            [dataList addObject:photoAssets];
        }
        
    }
    return dataList;
}

- (void) getAssetsPhotoWithURLs:(PHAsset *) asset callBack:(callBackBlock ) callBack withSize:(CGSize)size{
    PHImageRequestOptions* option=[[PHImageRequestOptions alloc]init];
    //允许使用网络下载图片
    option.networkAccessAllowed=YES;
    PHImageManager* imageManager=[PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        callBack(result);
    }];
    
}
@end
