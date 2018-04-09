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

- (void)removeModel {
    [self.modelArr removeAllObjects];
}

#pragma mark table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tablePickerView:numberOfRowsInComponent:)]) {
        return [self.dataSource tablePickerView:self.tablePickerView numberOfRowsInComponent:self.component];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tablePickerView:viewForRow:forComponent:)]) {
        UITableViewCell *cell = [self.dataSource tablePickerView:self.tablePickerView viewForRow:indexPath.row forComponent:self.component];
        return cell;
    }
    
    TablePickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TablePickerViewCell"];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tablePickerView:titleForRow:forComponent:)]) {
         NSString *title = [self.dataSource tablePickerView:self.tablePickerView titleForRow:indexPath.row forComponent:self.component];
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
        if (self.modelArr.count < [self.dataSource tablePickerView:self.tablePickerView numberOfRowsInComponent:self.component]) {
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
    
    if ([self getSelectKey] && [[self getSelectKey] isEqualToString:[NSString stringWithFormat:@"select_tag_%ld_%ld",self.component,indexPath.row]]) {
        return;
    }
    [self saveSelectKey:self.component row:indexPath.row];
    
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(tablePickerView:didSelectRow:inComponent:)]) {
            [self.delegate tablePickerView:self.tablePickerView didSelectRow:indexPath.row inComponent:self.component];
        }
    });
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tablePickerView:rowHeightForComponent:)]) {
        return [self.delegate tablePickerView:self.tablePickerView rowHeightForComponent:self.component];
    }
    return 49;
}

- (void) saveSelectKey:(NSInteger)component row:(NSInteger)row{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSString stringWithFormat:@"select_tag_%ld_%ld",component,row] forKey:@"selectkey"];
    [defaults synchronize];
}

- (NSString *)getSelectKey{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [defaults valueForKey:@"selectkey"];
    return key;
}


@end
