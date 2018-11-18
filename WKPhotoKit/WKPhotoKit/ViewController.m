//
//  ViewController.m
//  WKPhotoKit
//
//  Created by wangkang on 2018/11/18.
//  Copyright © 2018 wangkang. All rights reserved.
//

#import "ViewController.h"
#import "WKSelectPhotoPickerGroupVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WKSelectPhotoPickerGroupVC* vc=[[WKSelectPhotoPickerGroupVC alloc]initWithStyle:UITableViewStylePlain];
    vc.tableView.frame=self.view.bounds;
    [self.view addSubview:vc.tableView];
    [self addChildViewController:vc];
}


@end
