//
//  WFLineChartView.h
//  AnimationDemo
//
//  Created by Jack on 2018/4/13.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WFChartViewType) {
    WFChartViewTypeLine,
    WFChartViewTypeBar
};

@class WFChartModel,WFLineChartView;
@protocol WFLineChartViewDelegate <NSObject>
@optional

/**
 点击事件

 @param lineChartView 折线图
 @param button 对应按钮
 */
- (void)wf_lineChartView:(WFLineChartView *)lineChartView didClickButtonDot:(UIButton *)button;
@end

@interface WFLineChartView : UIView

/** 代理 */
@property (weak, nonatomic) id<WFLineChartViewDelegate> delegate;

/** 头部标题 */
@property (copy, nonatomic) NSString *headerTitle;
/** X轴文字 */
@property (copy, nonatomic) NSString *xAxisTitle;
/** Y轴文字 */
@property (copy, nonatomic) NSString *yAxisTitle;

/** X轴所要显示的数据 */
@property (strong, nonatomic) NSArray<NSString *> *xAxisTitleArray;
/** 是否显示网格 */
@property (assign, nonatomic) BOOL isShowGridding;
/** 是否按照10的倍数来显示（这种只能在一组数据的时候去设置） */
@property (assign, nonatomic) BOOL isShowInteger;
/** 是否填充 */
@property (assign, nonatomic) BOOL isFill;
/** 是否显示每个点的值 */
@property (assign, nonatomic) BOOL isShowValue;
/** 是否显示动画 */
@property (assign, nonatomic) BOOL isAnimation;
/** 是否显示为虚线 */
@property (nonatomic, assign) BOOL isDash;
/** bar的宽度 */
@property (assign, nonatomic) CGFloat barWidth;
/** 图形 */
@property (assign, nonatomic) WFChartViewType chartType;
/** 是否需要是曲线 */
@property (assign, nonatomic) BOOL isCurve;

/**
 初始化

 @param frame  frame
 @param titleArray X 轴显示
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray *)titleArray;

/**
 设置数据源

 @param dataSource 数据源数组
 */
- (void)showChartViewWithDataSource:(NSArray<WFChartModel *> *)dataSource;

@end
