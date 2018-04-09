//
//  TablePickerViewDelegate.h
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TablePickerView;

@protocol TablePickerViewDelegate <NSObject>

@optional
- (CGFloat) tablePickerView:(TablePickerView *)tablePickerView widthForComponent:(NSInteger)component;

- (CGFloat) tablePickerView:(TablePickerView *)tablePickerView rowHeightForComponent:(NSInteger)component;

- (void) tablePickerView:(TablePickerView *)tablePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
