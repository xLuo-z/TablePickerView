//
//  TablePickerViewModel.m
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "TablePickerViewModel.h"

@interface TablePickerViewModel ()

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation TablePickerViewModel

+(instancetype)model {
    TablePickerViewModel *model = [[TablePickerViewModel alloc] init];
    return model;
}

- (NSMutableArray *)modelArr {
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

#pragma mark table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(optionView:numberOfRowsInComponent:)]) {
        return [self.dataSource optionView:self.optionView numberOfRowsInComponent:self.component];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TablePickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TablePickerViewCell"];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(optionView:titleForRow:forComponent:)]) {
         NSString *title = [self.dataSource optionView:self.optionView titleForRow:indexPath.row forComponent:self.component];
        TablePickerModel *model = [[TablePickerModel alloc] init];
        model.title = title;
        cell.title = model.title;
        NSInteger index = 0;
        for (TablePickerModel *tempModel in self.modelArr) {
            if ([model isEqual:tempModel]) {
                break;
            }
            index ++;
        }
        if (self.modelArr.count < [self.dataSource optionView:self.optionView numberOfRowsInComponent:self.component]) {
            [self.modelArr addObject:model];
        }
        TablePickerModel *tempModel = self.modelArr[indexPath.row];
        cell.isSelect = [tempModel.isSelect boolValue];
    }
    if (self.titleFont) {
        cell.titleFont = self.titleFont;
    }
    if (self.titleColor) {
        cell.titleColor = self.titleColor;
    }
    if (self.titleTextAlignment) {
        cell.titleTextAlignment = self.titleTextAlignment;
    }
    if (self.selectColor) {
        cell.selectColor = self.selectColor;
    }
    if (self.narmolColor) {
        cell.narmolColor = self.narmolColor;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (TablePickerModel *model in self.modelArr) {
        if (indexPath.row < self.modelArr.count) {
            TablePickerModel *tempModel = self.modelArr[indexPath.row];
            model.isSelect = @(0);
            if ([model isEqual:tempModel]) {
                model.isSelect = @(1);
            }
        }
    }
    
    [tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(optionView:didSelectRow:inComponent:)]) {
            [self.delegate optionView:self.optionView didSelectRow:indexPath.row inComponent:self.component];
        }
    });
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(optionView:rowHeightForComponent:)]) {
        return [self.delegate optionView:self.optionView rowHeightForComponent:self.component];
    }
    return 49;
}


@end
