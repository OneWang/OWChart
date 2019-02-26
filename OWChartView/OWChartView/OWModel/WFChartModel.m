//
//  WFChartModel.m
//  AnimationDemo
//
//  Created by Jack on 2018/4/17.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "WFChartModel.h"

@implementation WFChartModel
+ (instancetype)modelWithColor:(UIColor *)color plots:(NSArray<NSString *> *)plots project:(NSString *)chartName {
    WFChartModel *model = [[self alloc] init];
    model.color = color;
    model.chartName = chartName;
    model.plotArray = plots;
    return model;
}
@end
