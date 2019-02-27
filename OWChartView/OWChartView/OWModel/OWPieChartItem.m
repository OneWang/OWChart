//
//  OWPieChartItem.m
//  AnimationDemo
//
//  Created by Jack on 2018/4/13.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "OWPieChartItem.h"

@implementation OWPieChartItem

+ (instancetype)wf_pieChartItemWithValue:(CGFloat)progress color:(UIColor *)color title:(NSString *)title titleColor:(UIColor *)textColor{
    OWPieChartItem *item = [[OWPieChartItem alloc] init];
    item.progress = progress;
    item.color = color;
    item.title = title;
    item.textColor = textColor;
    return item;
}

@end
