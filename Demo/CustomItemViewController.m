//
//  CustomItemViewController.m
//  Demo
//
//  Created by 技术部 on 2018/4/9.
//  Copyright © 2018年 Mr Zhang. All rights reserved.
//

#import "CustomItemViewController.h"
#import "TablePickerView.h"
#import "CustomTitleCell.h"
#import "CustomContentCell.h"

#define ISIphoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define NAV_HEIGHT  (ISIphoneX ? 88:64)

@interface CustomItemViewController ()<TablePickerViewDataSource,TablePickerViewDelegate>

@property (nonatomic, strong) TablePickerView *tablePickerView;

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation CustomItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"custom";
    
    if (@available(iOS 11.0, *)) {
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tablePickerView];
    
    [self loadData];
}

- (void) loadData {
    NSMutableArray *tempData = [@[
                        @{
                            @"name":@"title1",
                            @"sub":@[
                                      @{
                                          @"content":@"0000内容内容内容内容",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容内题标题标容内容容内容内容内标标标标标",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容内容内容",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容标题标题标题标题标题标题标题标题内容内容内容内容内容内容",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容内容内容",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容内题标题标容内容容内容内容内标标标标标",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容内容内容",
                                          @"subTitle":@"标题标题",
                                          },
                                      @{
                                          @"content":@"内容内容标题标题标题标题标题标题标题标题内容内容内容内容内容内容",
                                          @"subTitle":@"标题标题",
                                          },
                                    ]
                            },
                        @{
                            @"name":@"title2",
                            @"sub":@[
                                    @{
                                        @"content":@"1111内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容标题标题标题标题容内容内容内容内容内标题标题内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    ]
                            },
                        @{
                            @"name":@"title3",
                            @"sub":@[
                                    @{
                                        @"content":@"2222内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容内容内容内容内容内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容容内容容内容容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    @{
                                        @"content":@"内容内容内容内容",
                                        @"subTitle":@"标题标题",
                                        },
                                    ]
                            },
                        ] mutableCopy];
    
    self.titles = tempData;
    self.contents = self.titles[0][@"sub"];
}

#pragma mark 懒加载
- (TablePickerView *)tablePickerView {
    if (!_tablePickerView) {
        _tablePickerView = [[TablePickerView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - NAV_HEIGHT) delegate:self];
        [_tablePickerView registerNib:[UINib nibWithNibName:@"CustomTitleCell" bundle:nil] forCellReuseIdentifier:@"CustomTitleCell" forComponet:0];
        [_tablePickerView registerNib:[UINib nibWithNibName:@"CustomContentCell" bundle:nil] forCellReuseIdentifier:@"CustomContentCell" forComponet:1];
    }
    return _tablePickerView;
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents  = [NSMutableArray array];
    }
    return _contents;
}


#pragma mark option view data source
- (NSInteger)numberOfComponentsInTablePickerView:(TablePickerView *)tablePickerView {
    return 2;
}

- (NSInteger)tablePickerView:(TablePickerView *)tablePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.titles.count;
    }else{
        return self.contents.count;
    }
}

- (UITableViewCell *)tablePickerView:(TablePickerView *)tablePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *iddentifiers = @[@"CustomTitleCell",@"CustomContentCell"];
    if (component == 0) {
        CustomTitleCell *cell = (CustomTitleCell *)[tablePickerView dequeueReusableCellWithIdentifier:iddentifiers[component] forComponet:component];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = self.titles[row][@"name"];
        return cell;
    }
    CustomContentCell *cell = (CustomContentCell *)[tablePickerView dequeueReusableCellWithIdentifier:iddentifiers[component] forComponet:component];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content.text = self.contents[row][@"content"];
    return cell;
}

#pragma mark option view delegate
- (void)tablePickerView:(TablePickerView *)tablePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.contents = self.titles[row][@"sub"];
        [self.tablePickerView reloadComponent:1];
        //滚动到最上方
        [self.tablePickerView scrollToTopComponent:1];
    }else {
        
    }
}

- (CGFloat) tablePickerView:(TablePickerView *)tablePickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return self.view.frame.size.width / 3.0 * 1;
    }
    return self.view.frame.size.width / 3.0 * 2;
}

- (CGFloat)tablePickerView:(TablePickerView *)tablePickerView rowHeightForComponent:(NSInteger)component {
    if (component == 0) {
        return 80;
    }
    return 120;
}



@end
