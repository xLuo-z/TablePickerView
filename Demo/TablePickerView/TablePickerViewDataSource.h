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
- (NSInteger)numberOfComponentsInOptionView:(TablePickerView *)optionView;

@required
- (NSInteger)optionView:(TablePickerView *)optionView numberOfRowsInComponent:(NSInteger)component;

- (NSString *)optionView:(TablePickerView *)optionView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@end
