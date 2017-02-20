//
//  TablePickerView.m
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "TablePickerView.h"
#import "TablePickerViewModel.h"

@interface TablePickerView ()

@property (nonatomic, assign) NSInteger component;

@property (nonatomic, strong) NSMutableArray *viewArrays;

@property (nonatomic, strong) NSMutableArray *viewModels;

@end

@implementation TablePickerView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TablePickerViewDataSource,TablePickerViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = delegate;
        self.delegate = delegate;
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfComponentsInOptionView:)]) {
        self.component = [self.dataSource numberOfComponentsInOptionView:self];
    }else {
        self.component = 0;
    }
    CGFloat currentX = 0;
    for (NSInteger component = 0; component < self.component; component ++) {
        CGFloat c_width = [self.delegate optionView:self widthForComponent:component];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(currentX, 0, c_width, self.frame.size.height) style:UITableViewStylePlain];
        tableView.separatorStyle = self.cellSeparatorStyle;
        [tableView registerClass:[TablePickerViewCell class] forCellReuseIdentifier:@"TablePickerViewCell"];
        TablePickerViewModel *model = [TablePickerViewModel model];
        model.component = component;
        model.dataSource = self.dataSource;
        model.delegate = self.delegate;
        tableView.delegate = model;
        tableView.dataSource = model;
        
        [self addSubview:tableView];
        
        [self.viewArrays addObject:tableView];
        [self.viewModels addObject:model];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(currentX + c_width, 0, 1, self.frame.size.height)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
        currentX += c_width;
    }
    
}

#pragma mark 懒加载
- (NSMutableArray *)viewArrays {
    if (!_viewArrays) {
        _viewArrays = [NSMutableArray array];
    }
    return _viewArrays;
}

- (NSMutableArray *)viewModels {
    if (!_viewModels) {
        _viewModels = [NSMutableArray array];
    }
    return _viewModels;
}

- (void)reloadAllComponents {
    for (UITableView *tableView in self.viewArrays) {
        [tableView reloadData];
    }
}

- (void)reloadComponent:(NSInteger)component {
    UITableView *tableView = self.viewArrays[component];
    [tableView reloadData];
}

- (void)setTitleFont:(UIFont *)titleFont {
    for (TablePickerViewModel *model in self.viewModels) {
        model.titleFont = titleFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    for (TablePickerViewModel *model in self.viewModels) {
        model.titleColor = titleColor;
    }
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    for (TablePickerViewModel *model in self.viewModels) {
        model.titleTextAlignment = titleTextAlignment;
    }
}

- (void)setSelectColor:(NSMutableArray *)selectColor {
    for (NSInteger index = 0; index < selectColor.count; index ++) {
        TablePickerViewModel *model = self.viewModels[index];
        model.selectColor = selectColor[index];
    }
}

- (void)setNarmolColor:(NSMutableArray *)narmolColor {
    for (NSInteger index = 0; index < narmolColor.count; index ++) {
        TablePickerViewModel *model = self.viewModels[index];
        model.narmolColor = narmolColor[index];
        UITableView *tableView = self.viewArrays[index];
        tableView.backgroundColor = narmolColor[index];
    }
}


@end
