//
//  LineChartView.h
//  LineChart
//
//  Created by 庆庆 on 2017/8/23.
//  Copyright © 2017年 qingqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView

/**
 初始化折线图

 @param frame fram
 @param title 标题
 @param dataAry 折线数据
 @param bottomAry 折线底部数据
 */

-(instancetype)initWithFrame:(CGRect)frame titleForChart:(NSString *)title dataForChart:(NSArray *)dataAry titleBottom:(NSArray *)bottomAry;

@end
