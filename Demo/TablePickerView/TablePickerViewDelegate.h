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
- (CGFloat) optionView:(TablePickerView *)optionView widthForComponent:(NSInteger)component;

- (CGFloat) optionView:(TablePickerView *)optionView rowHeightForComponent:(NSInteger)component;

- (void) optionView:(TablePickerView *)optionView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
