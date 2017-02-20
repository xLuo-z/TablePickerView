//
//  TablePickerViewCell.m
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "TablePickerViewCell.h"

@interface TablePickerViewCell ()
/**文本承载label*/
@property (nonatomic, strong) UILabel *titleLabel;
/**背景视图*/
@property (nonatomic, strong) UIView *bgView;

@end

@implementation TablePickerViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:self.bgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width, self.frame.size.height)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    self.titleLabel.font = titleFont;
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    self.titleLabel.textAlignment = titleTextAlignment;
}

- (void)setIsSelect:(BOOL)isSelect {
    self.bgView.hidden = !isSelect;
}

- (void)setSelectColor:(UIColor *)selectColor {
    self.bgView.backgroundColor = selectColor;
}

- (void)setNarmolColor:(UIColor *)narmolColor {
    self.bgView.backgroundColor = narmolColor;
    self.contentView.backgroundColor = narmolColor;
}


@end
