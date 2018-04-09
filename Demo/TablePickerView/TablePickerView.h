//
//  TablePickerView.h
//  Demo
//
//  Created by 技术部 on 17/2/20.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TablePickerViewDelegate.h"
#import "TablePickerViewDataSource.h"

@interface TablePickerView : UIView

/**数据源代理*/
@property (nonatomic, weak) id<TablePickerViewDataSource>dataSource;
/**视图代理*/
@property (nonatomic, weak) id<TablePickerViewDelegate>delegate;
/**cell类型*/
@property (nonatomic, assign) UITableViewCellSeparatorStyle cellSeparatorStyle;
/**文本颜色*/
@property (nonatomic, strong) UIColor *titleColor;
/**文本字体*/
@property (nonatomic, strong) UIFont *titleFont;
/**文本对齐方式*/
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
/**选中颜色*/
@property (nonatomic, strong) NSMutableArray *selectColor;
/**未选中颜色*/
@property (nonatomic, strong) NSMutableArray *narmolColor;

/*!
 @brief 初始化视图
 @param frame 视图frame
 @param delegate 视图代理
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TablePickerViewDataSource,TablePickerViewDelegate>)delegate;

/*!
 @brief 刷新整个视图
 */
- (void)reloadAllComponents;

/*!
 @brief 刷新某一列视图
 @param component 列
 */
- (void)reloadComponent:(NSInteger)component;

/*!
 @brief 滚动到顶部
 @param component 列
 */
- (void) scrollToTopComponent:(NSInteger)component;

/*!
 @biref 获取复用cell
 @param identifier 复用唯一标识
 @param component 列
 @return 返回tableViewCell
 */
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forComponet:(NSInteger)component;

/*!
 @brief 使用xib创建cell
 @param identifier 复用唯一标识
 @param component 列
 */
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier forComponet:(NSInteger)component;

/*!
 @brief 使用纯代码创建cell
 @param identifier 复用唯一标识
 @param component 列
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier forComponet:(NSInteger)component;

@end
