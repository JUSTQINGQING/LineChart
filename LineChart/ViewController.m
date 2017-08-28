//
//  ViewController.m
//  LineChart
//
//  Created by 庆庆 on 2017/8/23.
//  Copyright © 2017年 qingqing. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    LineChartView *chartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 120) titleForChart:@"一车间 效率分析" dataForChart:@[@69,@96,@80,@70,@85] titleBottom:@[@"07-24",@"07-25",@"07-26",@"07-27",@"07-28"]];
    [self.view addSubview:chartView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
