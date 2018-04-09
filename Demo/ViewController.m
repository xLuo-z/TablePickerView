//
//  ViewController.m
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "ViewController.h"
#import "CustomItemViewController.h"
#import "NormalItemController.h"

@interface ViewController ()



@end

@implementation ViewController
- (void)noramlItemClicked:(UIButton *)sender {
    [self.navigationController pushViewController:[[NormalItemController alloc] init] animated:YES];
}
- (void)customItemClicked:(UIButton *)sender {
    [self.navigationController pushViewController:[[CustomItemViewController alloc] init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *normal = [UIButton buttonWithType:UIButtonTypeCustom];
    normal.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 40);
    [normal setTitle:@"Normal" forState:UIControlStateNormal];
    normal.backgroundColor = [UIColor lightGrayColor];
    [normal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    normal.titleLabel.font = [UIFont systemFontOfSize:16];
    [normal addTarget:self action:@selector(noramlItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normal];
    
    UIButton *custom = [UIButton buttonWithType:UIButtonTypeCustom];
    custom.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 40);
    [custom setTitle:@"Custom" forState:UIControlStateNormal];
    custom.backgroundColor = [UIColor lightGrayColor];
    [custom setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    custom.titleLabel.font = [UIFont systemFontOfSize:16];
    [custom addTarget:self action:@selector(customItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:custom];
}

@end
