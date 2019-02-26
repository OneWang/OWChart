//
//  OWViewController.m
//  OWChartView
//
//  Created by OneWang on 02/26/2019.
//  Copyright (c) 2019 OneWang. All rights reserved.
//

#import "OWViewController.h"
#import "WFLineChartView.h"
#import "WFChartModel.h"
#import "OWMacro.h"

@interface OWViewController ()
/** contentView */
@property (nonatomic, weak) UIScrollView *contentView;
/** 折线图 */
@property (nonatomic, weak) WFLineChartView *lineView;
/** 柱状图 */
@property (nonatomic, weak) WFLineChartView *barView;
@end

@implementation OWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.contentView = contentView;
    contentView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:contentView];
    
    UISwitch *switchBtn = [[UISwitch alloc] init];
    [contentView addSubview:switchBtn];
    [switchBtn addTarget:self action:@selector(showValue:) forControlEvents:UIControlEventValueChanged];
    UILabel *tiplabel1 = [[UILabel alloc] init];
    [contentView addSubview:tiplabel1];
    tiplabel1.text = @"是否显示值";
    tiplabel1.frame = CGRectMake(switchBtn.frame.size.width, 0, 100, 40);
    tiplabel1.textAlignment = NSTextAlignmentCenter;
    
    UISwitch *switchButton = [[UISwitch alloc] init];
    [contentView addSubview:switchButton];
    switchButton.frame = CGRectMake(150, 0, 0, 0);
    [switchButton addTarget:self action:@selector(showCurve:) forControlEvents:UIControlEventValueChanged];
    UILabel *tiplabel2 = [[UILabel alloc] init];
    [contentView addSubview:tiplabel2];
    tiplabel2.text = @"是否显示为曲线";
    tiplabel2.frame = CGRectMake(switchButton.frame.size.width + 150, 0, 140, 40);
    tiplabel2.textAlignment = NSTextAlignmentCenter;
    
    UISwitch *switchDash = [[UISwitch alloc] init];
    [contentView addSubview:switchDash];
    switchDash.frame = CGRectMake(0, 50, 0, 0);
    [switchDash addTarget:self action:@selector(showDash:) forControlEvents:UIControlEventValueChanged];
    UILabel *tiplabel3 = [[UILabel alloc] init];
    [contentView addSubview:tiplabel3];
    tiplabel3.text = @"是否显示为虚线";
    tiplabel3.frame = CGRectMake(switchDash.frame.size.width, 50, 140, 40);
    tiplabel3.textAlignment = NSTextAlignmentCenter;
    
    WFLineChartView *lineView = [[WFLineChartView alloc] initWithFrame:CGRectMake(0, 100, K_Screen_Width, 300) xTitleArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    lineView.isShowGridding = YES;
    self.lineView = lineView;
    lineView.isAnimation = YES;
    lineView.chartType = WFChartViewTypeLine;
    lineView.barWidth = 20.f;
    lineView.headerTitle = @"折线图";
    lineView.isShowInteger = YES;
    
    lineView.isDash = NO;
    WFChartModel *model = [WFChartModel modelWithColor:RandomColor plots:[self randomArrayWithCount:12] project:@"1组"];
    NSArray *dataSource = @[model];
    [lineView showChartViewWithDataSource:dataSource];
    [contentView addSubview:lineView];
    
    [self createCubeChart];
}

- (void)showValue:(UISwitch *)button{
    if (button.isOn) {
        _lineView.isShowValue = YES;
    }else{
        _lineView.isShowValue = NO;
    }
}

- (void)showCurve:(UISwitch *)button{
    if (button.isOn) {
        _lineView.isCurve = YES;
    }else{
        _lineView.isCurve = NO;
    }
}

- (void)showDash:(UISwitch *)button{
    if (button.isOn) {
        _lineView.isDash = YES;
    }else{
        _lineView.isDash = NO;
    }
}

- (void)createCubeChart{
    WFLineChartView *lineView = [[WFLineChartView alloc] initWithFrame:CGRectMake(0, 450, K_Screen_Width, 300) xTitleArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    lineView.isShowGridding = YES;
    lineView.isAnimation = YES;
    lineView.chartType = WFChartViewTypeBar;
    lineView.barWidth = 20.f;
    lineView.headerTitle = @"柱状图";
    lineView.isShowInteger = YES;
    WFChartModel *model = [WFChartModel modelWithColor:RandomColor plots:[self randomArrayWithCount:12] project:@"1组"];
    WFChartModel *model1 = [WFChartModel modelWithColor:RandomColor plots:[self randomArrayWithCount:12] project:@"2组"];
    WFChartModel *model2 = [WFChartModel modelWithColor:RandomColor plots:[self randomArrayWithCount:12] project:@"3组"];
    NSArray *dataSource = @[model,model1,model2];
    [lineView showChartViewWithDataSource:dataSource];
    [_contentView addSubview:lineView];
}

- (NSArray *)randomArrayWithCount:(NSInteger)dataCounts {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataCounts; i++) {
        NSString *number = [NSString stringWithFormat:@"%d",arc4random_uniform(1000)];
        [array addObject:number];
    }
    return array.copy;
}

@end
