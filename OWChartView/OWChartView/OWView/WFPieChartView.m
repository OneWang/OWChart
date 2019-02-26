//
//  WFPieChartView.m
//  AnimationDemo
//
//  Created by Jack on 2018/4/13.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "WFPieChartView.h"
#import "WFPieChartItem.h"

@interface WFPieChartView ()
/** 转换后的数据源数组 */
@property (strong, nonatomic) NSMutableArray *percentageArray;
/** 遮罩动画层 */
@property (weak, nonatomic) CAShapeLayer *maskLayer;
/** 半径 */
@property (assign, nonatomic) CGFloat radius;
/** 真实的线宽 */
@property (assign, nonatomic) CGFloat realWidth;
@end

@implementation WFPieChartView

//MARK:初始化方法
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<WFPieChartItem *> *)items radius:(CGFloat)radius{
    if (self = [super initWithFrame:frame]) {
        self.radius = radius;
        self.itemArray = items;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius{
    if (self = [super initWithFrame:frame]) {
        self.radius = radius;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.realWidth = _borderWidth * 2;
    [self p_initialMaskLayer];
    [self p_strokePineChart];
}

- (void)setItemArray:(NSArray<WFPieChartItem *> *)itemArray{
    _itemArray = itemArray;
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.realWidth = _borderWidth * 2;
    [self p_initialMaskLayer];
    [self p_strokePineChart];
}

//MARK:初始化遮罩层
- (void)p_initialMaskLayer{
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CAShapeLayer *mask = [CAShapeLayer layer];
    self.maskLayer = mask;
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:center radius:_radius - _realWidth * 0.5 - 1 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    mask.fillColor = [UIColor whiteColor].CGColor;
    mask.strokeColor = [UIColor orangeColor].CGColor;
    mask.lineWidth = _realWidth;
    mask.path = bezier.CGPath;
    mask.strokeEnd = 0;
    self.layer.mask = mask;
}

//MARK:转换数据
- (NSArray *)p_convertDataArray:(NSArray<WFPieChartItem *> *)dataArray{
    //计算数组中progress的和
    CGFloat totalCount = [[dataArray valueForKeyPath:@"@sum.progress"] floatValue];
    __weak typeof(self) weakSelf = self;
    __block CGFloat total = 0;
    [dataArray enumerateObjectsUsingBlock:^(WFPieChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (totalCount == 0) {
            [weakSelf.percentageArray addObject:@(1.0 / weakSelf.itemArray.count * (idx + 1))];
        }else{
            total += obj.progress;
            [weakSelf.percentageArray addObject:@(total/totalCount)];
        }
    }];
    return self.percentageArray;
}

//MARK:绘制饼状图
- (void)p_strokePineChart{
    self.piePace = _itemArray.count < 3 ? 0 : _piePace;
    NSArray *dataArray = [self p_convertDataArray:_itemArray];
    for (int i = 0; i < _itemArray.count; i ++) {
        WFPieChartItem *item = _itemArray[i];
        CGFloat start = 0.f;
        if (i != 0) {
            start = [dataArray[i - 1] floatValue];
        }
        CGFloat end = [dataArray[i] floatValue];
        CAShapeLayer *layer = [self p_drawCicleLayerWithRadius:_radius borderWidth:_realWidth fillColor:[UIColor clearColor] borderColor:item.color startValue:start endValue:end];
        [self.layer addSublayer:layer];
    }
    for (int i = 0; i < _itemArray.count; i ++) {
        CGFloat start = 0.f;
        if (i != 0) {
            start = [dataArray[i - 1] floatValue];
        }
        CGFloat end = [dataArray[i] floatValue];
        UILabel *label = [self p_createCircleDescriptionLabelWithIndex:i start:start end:end];
        [self addSubview:label];
    }
    [self p_addAnimation];
}

/**
 图像layer
 @param radius 圆环半径
 @param borderWidth 线宽度
 @param fillColor 填充颜色
 @param borderColor 线的颜色
 @param start 开始点
 @param end 结束点
 */
- (CAShapeLayer *)p_drawCicleLayerWithRadius:(CGFloat)radius
                               borderWidth:(CGFloat)borderWidth
                                 fillColor:(UIColor *)fillColor
                               borderColor:(UIColor *)borderColor
                                startValue:(CGFloat)start
                                  endValue:(CGFloat)end{
    CAShapeLayer *layer = [CAShapeLayer layer];
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    layer.fillColor     = fillColor.CGColor;
    layer.strokeColor   = borderColor.CGColor;
    layer.strokeStart   = start;
    layer.strokeEnd     = end;
    layer.lineWidth     = borderWidth;
    layer.path          = path.CGPath;
    return layer;
}

- (UILabel *)p_createCircleDescriptionLabelWithIndex:(NSInteger)index start:(CGFloat)start end:(CGFloat)end{
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    WFPieChartItem *item = _itemArray[index];
    descriptionLabel.text = [NSString stringWithFormat:@"%.0f%%\n%@",(end - start) * 100,item.title];
    //获取中间点的角度
    CGFloat angle = (start + end) * 0.5 * M_PI * 2;
    CGFloat centerX = _radius + _radius * 0.5 * sinf(angle) + (self.bounds.size.width - _radius * 2) * 0.5;
    CGFloat centerY = _radius - _radius * 0.5 * cosf(angle) + (self.bounds.size.width - _radius * 2) * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    CGSize size = [descriptionLabel.text sizeWithAttributes:@{NSFontAttributeName : descriptionLabel.font}];
    CGRect frame = CGRectMake(descriptionLabel.frame.origin.x, descriptionLabel.frame.origin.y, size.width, size.height);
    descriptionLabel.frame = frame;
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.font = [UIFont systemFontOfSize:12];
    descriptionLabel.textColor = item.textColor;
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.center = center;
    return descriptionLabel;
}

//MARK:添加动画
- (void)p_addAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    //禁止还原
    animation.autoreverses = NO;
    //禁止完成即移除
    animation.removedOnCompletion = NO;
    //让动画保持在最后状态
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_maskLayer addAnimation:animation forKey:@"strokeEnd"];
}

//MARK:添加点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    //触摸点
    CGPoint touchPoint = [touch locationInView:touch.view];
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    //距离中心点的距离
    CGFloat distanceFromCenter = sqrtf(pow(touchPoint.x - center.x, 2.f) + powf(touchPoint.y - center.y, 2.f));
    if (distanceFromCenter < _radius - _realWidth * 0.5 || distanceFromCenter > _radius) {
        return;
    }
    //取得触摸点的角度值
    CGFloat percentage = [self p_findPercentageOfAngleInCircleCenter:center fromPoint:touchPoint];
    NSInteger index = 0;
    while (percentage > [_percentageArray[index] floatValue]) {
        index ++;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(wf_pieChartView:didClickIndex:)]) {
        [self.delegate wf_pieChartView:self didClickIndex:index];
    }
    NSLog(@"索引值：%ld",(long)index);
}

//MARK:计算触摸点所占进度
- (CGFloat)p_findPercentageOfAngleInCircleCenter:(CGPoint)center fromPoint:(CGPoint)reference{
    //Find angle of line Passing In Reference And Center
    CGFloat angleOfLine = atanf((reference.y - center.y) / (reference.x - center.x));
    CGFloat percentage = (angleOfLine + M_PI_2)/(2 * M_PI);
    return (reference.x - center.x) > 0 ? percentage : percentage + .5;
}

#pragma mark - setter and geter
- (NSMutableArray *)percentageArray{
    if (!_percentageArray) {
        _percentageArray = [NSMutableArray array];
    }
    return _percentageArray;
}

@end
