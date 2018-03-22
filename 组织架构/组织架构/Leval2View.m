//
//  Leval2View.m
//  组织架构
//
//  Created by zhiyiqian on 2016/11/22.
//  Copyright © 2016年 zhiyiqian. All rights reserved.
//

#import "Leval2View.h"

@interface Leval2View ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSArray * scrollSubViews;
@property (nonatomic,strong) UIPageControl * page;
@property (nonatomic,strong) NSMutableArray *items;
@end

@implementation Leval2View


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat unitW = 90;
        CGFloat unitH = 130;
        NSInteger count = 10;
        _items = [NSMutableArray array];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, unitW, unitH)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.center = CGPointMake(self.bounds.size.width/2.0, unitH/2.0);
        _scrollView.contentSize = CGSizeMake(unitW * count, unitH);
        [self addSubview:_scrollView];
        
        NSMutableArray * array = [[NSMutableArray alloc]init];
        for (int i = 0; i < count; i++)
        {
            UIButton * leval2UnitView = [[UIButton alloc]initWithFrame:CGRectMake(i * unitW, 0, unitW, unitH)];
            leval2UnitView.backgroundColor = [UIColor whiteColor];
            CGRect bounds = leval2UnitView.bounds;
            bounds.origin.y = bounds.size.height;
            bounds.origin.x = 2;
            bounds.size.height = 2;
            bounds.size.width = bounds.size.width - 4;
            leval2UnitView.layer.shadowPath = [UIBezierPath bezierPathWithRect:bounds].CGPath;
            leval2UnitView.layer.shadowColor = [UIColor blackColor].CGColor;
            leval2UnitView.layer.shadowOpacity = 0.8;
            leval2UnitView.tag = i;
            [leval2UnitView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_items addObject:leval2UnitView];
            
            // 设置头像
            UIImageView * avaterIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
            avaterIcon.image = [UIImage imageNamed:@"toxiang"];
            avaterIcon.layer.cornerRadius = avaterIcon.frame.size.height/2.0;
            avaterIcon.layer.masksToBounds = YES;
            [leval2UnitView addSubview:avaterIcon];
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, unitW, 11)];
            nameLabel.text = @"姓名";
            nameLabel.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
            [leval2UnitView addSubview:nameLabel];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.font = [UIFont systemFontOfSize:10];
            
            UILabel * locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 94, unitW, 11)];
            locationLabel.text = @"部门";
            locationLabel.textAlignment = NSTextAlignmentCenter;
            locationLabel.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
            locationLabel.font = [UIFont systemFontOfSize:10];
            [leval2UnitView addSubview:locationLabel];
            
            UILabel * jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 109, unitW, 11)];
            jobLabel.text = @"职位";
            jobLabel.textAlignment = NSTextAlignmentCenter;
            
            jobLabel.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
            jobLabel.font = [UIFont systemFontOfSize:10];
            [leval2UnitView addSubview:jobLabel];
            [_scrollView addSubview:leval2UnitView];
            [array addObject:leval2UnitView];
        }
        
        UIPageControl * page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 10, frame.size.width, 10)];
        page.userInteractionEnabled = NO;
        page.numberOfPages = count;
        page.pageIndicatorTintColor = [UIColor colorWithRed:0.77f green:0.91f blue:0.97f alpha:1.00f];
        page.currentPageIndicatorTintColor = [UIColor colorWithRed:0.02f green:0.69f blue:1.00f alpha:1.00f];
        _page = page;
        [self addSubview:page];
        
        _scrollSubViews = array;
        if (array.count >= 2)
        {
            _scrollView.contentOffset = CGPointMake(unitW, 0);
            page.currentPage = 1;
        }
        else
        {
            page.currentPage = 0;
        }
        [self scrollViewDidScroll:_scrollView];
        
    }
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint newP = [self convertPoint:point toView:self];
    if ([self pointInside:newP withEvent:event]) {
        
        for (UIButton *itemView in _items) {
            CGRect frame = [itemView convertRect:itemView.bounds toView:self];
            if (CGRectContainsPoint(frame, newP)) {
                return itemView;
            }
        }
        return self.scrollView;
    }
    
    return [super hitTest:point withEvent:event];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat viewHeight = scrollView.frame.size.width;
    for (UIView * subView in _scrollSubViews)
    {
        CGFloat y = subView.center.x - scrollView.contentOffset.x;
        CGFloat p = y - viewHeight / 2;
        float scale = cos(0.6 * p / viewHeight);
        
        if (scale<0.7)
        {
            scale = 0.7;
        }
        subView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)btnClick:(UIButton *)btn {
    [_scrollView setContentOffset:CGPointMake(btn.tag * self.scrollView.frame.size.width, 0) animated:YES];
    NSLog(@"%zd",btn.tag);
}
@end
