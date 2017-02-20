//
//  TablePickerViewModel.h
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TablePickerViewDelegate.h"
#import "TablePickerViewDataSource.h"
#import "TablePickerViewCell.h"
#import "TablePickerModel.h"

@class TablePickerView;

@interface TablePickerViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

+ (instancetype)model;

@property (nonatomic, assign) NSInteger component;

@property (nonatomic, weak) id<TablePickerViewDataSource>dataSource;

@property (nonatomic, weak) id<TablePickerViewDelegate>delegate;

@property (nonatomic, weak) TablePickerView *optionView;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

@property (nonatomic, strong) UIColor *selectColor;

@property (nonatomic, strong) UIColor *narmolColor;

@end
