//
//  LineChartView.m
//  LineChart
//
//  Created by 庆庆 on 2017/8/23.
//  Copyright © 2017年 qingqing. All rights reserved.
//

#import "LineChartView.h"

//view的宽高
#define LCheight self.frame.size.height
#define LCwidth self.frame.size.width
//折线主题颜色
#define LCcolor [UIColor orangeColor]
//上下边距
CGFloat margin=15.f;
//折线点的弧度 直径为radius*2
CGFloat radius=3.f;

@interface LineChartView ()
//标题
@property(nonatomic,strong)UILabel *titleLabel;
//折线
@property(nonatomic,strong)CAShapeLayer *linePath;
//折线图数据点的平均高度
@property(nonatomic,assign)CGFloat avgHeight;
//折线图最大数值 默认0 - 100
@property(nonatomic,assign)NSInteger maxValue;
//数据个数
@property(nonatomic,assign)NSInteger count;
//标题
@property(nonatomic,copy)NSString *title;
//折线数据
@property(nonatomic,strong)NSArray *dataAry;
//底部数据
@property(nonatomic,strong)NSArray *bottomAry;

@end

@implementation LineChartView

-(instancetype)initWithFrame:(CGRect)frame titleForChart:(NSString *)title dataForChart:(NSArray *)dataAry titleBottom:(NSArray *)bottomAry
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _linePath=[CAShapeLayer layer];
        _linePath.lineCap=kCALineCapRound;
        _linePath.lineJoin=kCALineJoinBevel;
        _linePath.lineWidth=1;
        _linePath.fillColor=[UIColor clearColor].CGColor;
        [self.layer addSublayer:_linePath];
        _maxValue=100;
        _title = title;
        _dataAry = dataAry;
        _bottomAry = bottomAry;
    }
    return self;
}

-(NSInteger)count
{
    return _dataAry.count;
}
-(CGFloat)avgHeight
{
    _avgHeight=(LCheight-3*margin-44)/self.maxValue;
    return _avgHeight;
}

-(void)drawRect:(CGRect)rect
{
    self.titleLabel.text = _title;
    UIBezierPath *path=[UIBezierPath bezierPath];
    for (int i = 0; i < self.count; i++) {
        //设置坐标点
        CGPoint point = CGPointMake(40+(LCwidth-80)/(self.count-1)*i,LCheight-27-[self.dataAry[i] integerValue]*self.avgHeight);
        if (i==0) {
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:point];
        }
        
        UIBezierPath *drawPoint=[UIBezierPath bezierPath];
        [drawPoint addArcWithCenter:point radius:radius startAngle:M_PI*0 endAngle:M_PI*2 clockwise:YES];
        CAShapeLayer *layer=[[CAShapeLayer alloc]init];
        layer.path=drawPoint.CGPath;
        //修改点点颜色
        layer.fillColor = [UIColor orangeColor].CGColor;
        _linePath.strokeEnd=1;
        
        [self.layer addSublayer:layer];
        //设置点显示的文字
        NSString *valueString=[NSString stringWithFormat:@"%ld%%",[self.dataAry[i] integerValue]];
        CGRect frame=[valueString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f]} context:nil];
        //修改文字的位置
        CGPoint pointForValueString=CGPointMake(point.x-frame.size.width/2+5, point.y-25);
        //点的文字的颜色
        [valueString drawAtPoint:pointForValueString withAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]}];
        //底部文字
        NSString *titleForXLabel = self.bottomAry[i];
        NSDictionary *font=@{NSFontAttributeName: [UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName: [UIColor grayColor]};
        CGSize size=[titleForXLabel boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:font context:nil].size;
        point.x-=size.width/2;
        point.y = LCheight - 21;
        [titleForXLabel drawAtPoint:point withAttributes:font];
    }
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses=NO;
    _linePath.path=path.CGPath;
    //修改画笔颜色
    _linePath.strokeColor=[UIColor orangeColor].CGColor;
    [_linePath addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _linePath.strokeEnd = 1.0;
    
    
}

//设置标题参数
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 200, 15)];
        _titleLabel.font=[UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
    
}

@end
