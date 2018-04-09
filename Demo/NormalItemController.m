//
//  NormalItemController.m
//  Demo
//
//  Created by 技术部 on 2018/4/9.
//  Copyright © 2018年 Mr Zhang. All rights reserved.
//

#import "NormalItemController.h"
#import "TablePickerView.h"

#define ISIphoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define NAV_HEIGHT  (ISIphoneX ? 88:64)

@interface NormalItemController ()<TablePickerViewDataSource,TablePickerViewDelegate>

@property (nonatomic, strong) TablePickerView *tablePickerView;

@property (nonatomic, strong) NSMutableArray *provinceArr;

@property (nonatomic, strong) NSMutableArray *cityArr;

@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, strong) NSMutableDictionary *result;

@end

@implementation NormalItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"normal";
    
    if (@available(iOS 11.0, *)) {
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tablePickerView];
    
    [self loadData];
}

- (void) loadData {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"address" ofType:@"plist"];
    NSDictionary*addressDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.provinceArr = [addressDic[@"address"] mutableCopy];
    self.cityArr = self.provinceArr[0][@"sub"];
    self.areaArr = self.cityArr[0][@"sub"];
    [self.tablePickerView reloadAllComponents];
}

#pragma mark 懒加载
- (TablePickerView *)tablePickerView {
    if (!_tablePickerView) {
        _tablePickerView = [[TablePickerView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - NAV_HEIGHT) delegate:self];
        _tablePickerView.selectColor = [@[[UIColor lightGrayColor],[UIColor yellowColor],[UIColor purpleColor]] mutableCopy];
    }
    return _tablePickerView;
}

- (NSMutableArray *)provinceArr {
    if (!_provinceArr) {
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

- (NSMutableArray *)cityArr {
    if (!_cityArr) {
        _cityArr = [NSMutableArray array];
    }
    return _cityArr;
}

- (NSMutableArray *)areaArr {
    if (!_areaArr) {
        _areaArr = [NSMutableArray array];
    }
    return _areaArr;
}

- (NSMutableDictionary *)result {
    if (!_result) {
        _result = [NSMutableDictionary dictionary];
    }
    return _result;
}

#pragma mark option view data source
- (NSInteger)numberOfComponentsInTablePickerView:(TablePickerView *)tablePickerView {
    return 3;
}

- (NSInteger)tablePickerView:(TablePickerView *)tablePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArr.count;
    }else if (component == 1){
        return self.cityArr.count;
    }else{
        return self.areaArr.count;
    }
}

- (NSString *)tablePickerView:(TablePickerView *)tablePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    if (component == 0) {
        title = self.provinceArr[row][@"name"];
    }else if(component == 1){
        title = self.cityArr[row][@"name"];
    }else {
        title = self.areaArr[row];
    }
    return title;
}

#pragma mark option view delegate
- (void)tablePickerView:(TablePickerView *)tablePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        self.cityArr = self.provinceArr[row][@"sub"];
        if (self.cityArr.count) {
            self.areaArr = self.cityArr[0][@"sub"];
        }else {
            self.areaArr = self.cityArr;
        }
        [self.tablePickerView reloadComponent:1];
        [self.tablePickerView reloadComponent:2];
        [self.result setObject:self.provinceArr[row][@"name"] forKey:@"province"];
    }else if(component == 1){
        self.areaArr = self.cityArr[row][@"sub"];
        [self.tablePickerView reloadComponent:2];
        [self.result setObject:self.cityArr[row][@"name"] forKey:@"city"];
        
    }else {
        [self.result setObject:self.areaArr[row] forKey:@"area"];
        NSLog(@"%@",self.result);
    }
    
}

- (CGFloat) tablePickerView:(TablePickerView *)tablePickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width / 3.0;
}






@end
