//
//  MXPullDownMenu000.m
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MXPullDownMenu.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "AppDelegate.h"

@implementation MXPullDownMenu
{
    
    UIColor *_menuColor;//菜单颜色
    

    UIView *_backGroundView;
    UITableView *_tableView;
    
    NSMutableArray *_titles;
    NSMutableArray *_indicators;
    
    UIView *_redline;//选中时底部红色线条
    
    NSInteger _currentSelectedMenudIndex;
    bool _show;
    
    NSInteger _numOfMenu;
    
    NSMutableArray *_array;
    NSMutableArray *_subArray1;
    NSMutableArray *_subArray2;
    NSMutableArray *_subArray3;
    
    UIImageView *_image;//下拉菜单的cell中的圆圈
    
    NSMutableArray *listDataSource;
    NSMutableArray *listValueDataSource;
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    
    }
    return self;
}

- (MXPullDownMenu *)initWithArray:(NSMutableArray *)array Frame:(CGRect)frame selectedColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        
        _array = [NSMutableArray array];
        _subArray1 = [NSMutableArray array];
        _subArray2 = [NSMutableArray array];
        _subArray3 = [NSMutableArray array];

        self.frame = frame;
        
        _menuColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        
        [_subArray1 addObject:array[0]];
        [_subArray2 addObject:array[1]];
        [_subArray3 addObject:array[2]];
        [_array addObject:_subArray1];
        [_array addObject:_subArray2];
        [_array addObject:_subArray3];
        
        _numOfMenu = _array.count;
        
        CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
//        CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            //添加标题
            CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval-10 , self.frame.size.height / 2);
            CATextLayer *title = [self creatTextLayerWithNSString:_array[i][0] withColor:_menuColor andPosition:position];
            [self.layer addSublayer:title];
            [_titles addObject:title];
            
            //添加三角形图标
            CAShapeLayer *indicator = [self creatIndicatorWithColor:_menuColor andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
//            
//            if (i != _numOfMenu - 1) {
//                CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height / 2);
//                CAShapeLayer *separator = [self creatSeparatorLineWithColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0] andPosition:separatorPosition];
//                [self.layer addSublayer:separator];
//            }
            
        }
        
        //底部分割线
        UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        [separator setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [self addSubview:separator];
        
        
        _tableView = [self creatTableViewAtPosition:CGPointMake(0, self.frame.origin.y + self.frame.size.height+20)];
        _tableView.tintColor = color;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
         
        _currentSelectedMenudIndex = -1;
        _show = NO;
    }
    return self;
}

- (void)refreshListWithArray1:(NSMutableArray *)array1  Array2:(NSMutableArray *)array2  Array3:(NSMutableArray *)array3{
    for (int i = 0; i<array1.count; i++) {
        [_subArray1 addObject:array1[i]];
    }
    for (int j=0; j<array2.count; j++) {
        [_subArray2 addObject:array2[j]];
    }
    for (int k = 0; k<array3.count; k++) {
        [_subArray3 addObject:array3[k]];
    }

}


#pragma mark - tapEvent



// 处理菜单点击事件.
- (void)tapMenu:(UITapGestureRecognizer *)paramSender
{
    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 得到tapIndex
    
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    
    [_redline removeFromSuperview];

    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                }];
            }];
        }
    }
    
    //关闭下拉菜单
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
            [_redline removeFromSuperview];
        }];
        
    } else {
        
        //打开下拉菜单
        _currentSelectedMenudIndex = tapIndex;
        [_tableView reloadData];
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
            
         //添加选中红线
            _redline = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/_numOfMenu*_currentSelectedMenudIndex, self.frame.size.height-0.5, self.frame.size.width/_numOfMenu, 0.5)];
            [_redline setBackgroundColor:[UIColor redColor]];
            [self addSubview:_redline];
        }];
        
    }

}

//点击下拉菜单其他地方
- (void)tapBackGround:(UITapGestureRecognizer *)paramSender
{
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
        [_redline removeFromSuperview];
    }];

}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [_redline removeFromSuperview];
    [_image setImage:[UIImage imageNamed:@"wm_selected_ico1"]];
    [self confiMenuWithSelectRow:indexPath.row+1];
    [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row];
    
}


#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array[_currentSelectedMenudIndex] count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    //添加文字
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, (cell.bounds.size.height-25)/2, cell.bounds.size.width-50, 20)];
    [label setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
    label.text = _array[_currentSelectedMenudIndex][indexPath.row+1];
    [label setFont:[UIFont systemFontOfSize:13.0]];
    [label setTextColor:[UIColor blackColor]];
    [cell addSubview:label];
    
    //前面的圆圈
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(15, (cell.bounds.size.height-20)/2, 15, 15)];
    CATextLayer *_currentTitle = _titles[_currentSelectedMenudIndex];
    if ([label.text isEqual: _currentTitle.string]) {
          [_image setImage:[UIImage imageNamed:@"wm_selected_ico1"]];
        }
    else{
              [_image setImage:[UIImage imageNamed:@"wm_option_ico"]];
    
    }
    
    [cell addSubview:_image];

    
    //底部分割线
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-0.5, cell.frame.size.width, 0.5)];
    seperator.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [cell addSubview:seperator];
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
//    if (label.text == [[_titles objectAtIndex:_currentSelectedMenudIndex] string]) {
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        [label setTextColor:[tableView tintColor]];
//    }
    
    return cell;
}


#pragma mark - animation

- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim andValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    indicator.fillColor = forward ? _tableView.tintColor.CGColor : _menuColor.CGColor;
    
    complete();
}





- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete
{
    
    if (show) {
        
        [self.superview addSubview:view];
        [view.superview addSubview:self];

        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
    complete();
    
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete
{
    if (show) {
        
        
        tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        
        
        CGFloat tableViewHeight = ([tableView numberOfRowsInSection:0] > 5) ? (5 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewHeight);
        }];

    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [tableView removeFromSuperview];
        }];
        
        
    }
    complete();
    
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete
{
    if (show) {
        title.foregroundColor = _tableView.tintColor.CGColor;
    } else {
        title.foregroundColor = _menuColor.CGColor;
    }
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    
    
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}


#pragma mark - drawing


- (CAShapeLayer *)creatIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.8;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)creatSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)creatTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point
{
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 13.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}


- (UITableView *)creatTableViewAtPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    
    tableView.frame = CGRectMake(point.x, point.y, self.frame.size.width, 0);
    tableView.rowHeight = 40;
    
    return tableView;
}


#pragma mark - otherMethods


- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 13.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

- (void)confiMenuWithSelectRow:(NSInteger)row
{
    
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    title.string = [[_array objectAtIndex:_currentSelectedMenudIndex] objectAtIndex:row];
    
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
        
    }];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}


@end

#pragma mark - CALayer Category

@implementation CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath
{
    [self addAnimation:anim forKey:keyPath];
    [self setValue:value forKeyPath:keyPath];
}


@end
