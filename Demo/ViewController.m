//
//  ViewController.m
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "ViewController.h"
#import "TablePickerView.h"

@interface ViewController ()<TablePickerViewDataSource,TablePickerViewDelegate>

@property (nonatomic, strong) TablePickerView *tablePickerView;

@property (nonatomic, strong) NSMutableArray *provinceArr;

@property (nonatomic, strong) NSMutableArray *cityArr;

@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, strong) NSMutableDictionary *result;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
        _tablePickerView = [[TablePickerView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) delegate:self];
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
- (NSInteger)numberOfComponentsInOptionView:(TablePickerView *)optionView {
    return 3;
}

- (NSInteger)optionView:(TablePickerView *)optionView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArr.count;
    }else if (component == 1){
        return self.cityArr.count;
    }else{
        return self.areaArr.count;
    }
}

- (NSString *)optionView:(TablePickerView *)optionView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
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
- (void)optionView:(TablePickerView *)optionView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
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

- (CGFloat) optionView:(TablePickerView *)optionView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width / 3.0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
