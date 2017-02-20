//
//  TablePickerViewCell.h
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TablePickerViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

@property (nonatomic, strong) UIColor *selectColor;

@property (nonatomic, strong) UIColor *narmolColor;

@property (nonatomic, assign) BOOL isSelect;

@end
