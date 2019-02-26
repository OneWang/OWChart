//
//  WFChartModel.h
//  AnimationDemo
//
//  Created by Jack on 2018/4/17.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WFChartModel : NSObject
/** 颜色 */
@property (strong, nonatomic) UIColor *color;
/** 图标名称 */
@property (copy, nonatomic) NSString *chartName;
/** 点 */
@property (strong, nonatomic) NSArray<NSString *> *plotArray;

+ (instancetype)modelWithColor:(UIColor *)color plots:(NSArray<NSString *> *)plots project:(NSString *)chartName;
@end
