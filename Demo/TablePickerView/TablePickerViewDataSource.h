//
//  TablePickerViewDataSource.h
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TablePickerView;

@protocol TablePickerViewDataSource <NSObject>

@optional
- (NSInteger)numberOfComponentsInTablePickerView:(TablePickerView *)tablePickerView;

- (NSString *)tablePickerView:(TablePickerView *)tablePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
/*!
 @brief 自定义每个选项视图，如果现实该代理方法，tablePickerView:titleForRow: forComponent:方法将hi无效
 */
- (UITableViewCell *)tablePickerView:(TablePickerView *)tablePickerView  viewForRow:(NSInteger)row forComponent:(NSInteger)component;

@required
- (NSInteger)tablePickerView:(TablePickerView *)tablePickerView numberOfRowsInComponent:(NSInteger)component;




@end
