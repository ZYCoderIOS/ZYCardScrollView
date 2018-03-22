//
//  ViewController.m
//  组织架构
//
//  Created by zhiyiqian on 2016/11/21.
//  Copyright © 2016年 zhiyiqian. All rights reserved.
//

#import "OrganizationViewController.h"
#import "Leval2View.h"

@interface OrganizationViewController ()
@property (nonatomic,strong) Leval2View * leval2View;
@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    
    // 中间卡片
    [self buildLeval2View];
    
}

- (void)buildLeval2View
{
    // 中间
    CGFloat unitH = 130 + 20;
    Leval2View * parentView = [[Leval2View alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, unitH)];
    [self.view addSubview:parentView];
    _leval2View = parentView;
}
@end
