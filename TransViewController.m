//
//  TransViewController.m
//  CollectiveView
//
//  Created by ky on 16/4/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TransViewController.h"

#define PI 3.1415926
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TransViewController ()

@property (nonatomic, retain) UIView *testView;
@property (nonatomic, retain) UIView *pointView;
@property (nonatomic, retain) UIView *centerView;
@property (nonatomic, retain) IBOutlet UILabel *ibCoorLabel;
@property (nonatomic, retain) IBOutlet UILabel *ibCoorTap;
@property (nonatomic, assign) CGPoint orig;
@property (nonatomic, assign) CGPoint origCenter;
@property (nonatomic, assign) CGPoint origTopLeft;

@end

@implementation TransViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_testView setClipsToBounds:NO];
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
    
    view.backgroundColor = [UIColor yellowColor];
    
    [_testView addSubview:view];
    
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
    
    [_centerView setBackgroundColor:[UIColor blueColor]];
    
    [_testView addSubview:_centerView];
    
    _centerView.center = CGPointMake(50, 50);
    
    _pointView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 4, 4)];
    
    _pointView.transform = CGAffineTransformRotate(_pointView.transform, 0.33 * PI);
    
    _pointView.backgroundColor = [UIColor greenColor];
    
    [_testView addSubview:_pointView];
    
    [_testView setBackgroundColor:[UIColor redColor]];
    
    _testView.layer.borderWidth = 1;
    
    [self.view addSubview:_testView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    _origCenter = _testView.center;
    
    _origTopLeft = _testView.frame.origin;
    
    _orig = CGPointMake(0.5 * kScreenWidth, 0.5 * kScreenHeight);
    
    [_ibCoorTap setText:[NSString stringWithFormat:@"%d, %d", (int)self.view.bounds.size.width, (int)self.view.bounds.size.height]];
}

- (void)tap:(UITapGestureRecognizer*)sender {
    
    CGPoint point = [sender locationInView:self.view];
    
    [_ibCoorTap setText:[NSString stringWithFormat:@"%d, %d", (int)point.x, (int)point.y]];
}

CGPoint pointAddPoint(CGPoint a, CGPoint b) {
    
    return CGPointMake(a.x + b.x, a.y + b.y);
}

CGPoint pointMinusPoint(CGPoint a, CGPoint b) {
    
    return CGPointMake(a.x - b.x, a.y - b.y);
}

CGPoint operator+(const CGPoint& lhs, const CGPoint& rhs) {
    
    return pointAddPoint(lhs, rhs);
}

CGPoint operator-(const CGPoint& lhs, const CGPoint& rhs) {
    
    return pointMinusPoint(lhs, rhs);
}

CGPoint operator*(const CGPoint& lhs, CGFloat scale) {
    
    return CGPointMake(lhs.x * scale, lhs.y * scale);
}

CGPoint operator*(const CGPoint& lhs, const CGAffineTransform& tm) {
    
    return CGPointApplyAffineTransform(lhs, tm);
}

- (void)changeAnchorPoint:(CGPoint)p view:(UIView*)view {
    
    CGPoint center = view.center;
    
    CGPoint p0 = CGPointMake(view.layer.anchorPoint.x * view.bounds.size.width, view.layer.anchorPoint.y * view.bounds.size.height) ;
    
    CGPoint p1 = CGPointMake(p.x/view.bounds.size.width, p.y/view.bounds.size.height);
    
    center = center + p - p0;
    
    _testView.center = center;
    
    _testView.layer.anchorPoint = p1;
}

- (IBAction)tran:(id)sender {
    
    _testView.center = _testView.center + CGPointMake(30, 40);
}

- (IBAction)rotate:(id)sender {
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _testView.transform = CGAffineTransformRotate(_testView.transform, 0.25 * PI);
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            
        }
    }];
    
//    [self displayCoord];
}

- (IBAction)scale:(id)sender {
    
    CGAffineTransform transform = CGAffineTransformScale(_testView.transform, 1.2, 1.3);
    
    _testView.transform = transform;
    
//    [self displayCoord];
}

- (IBAction)ajust:(id)sender {
    
    [self displayCoord];
}

CGAffineTransform matrixMultiplyMatrix(CGAffineTransform a, CGAffineTransform b) {
    
    CGAffineTransform temp;
    
    temp.a = a.a * b.a + a.b * b.c;
    
    temp.b = a.a * b.b + a.b * b.d;
    
    temp.c = a.c * b.a + a.d * b.c;
    
    temp.d = a.c * b.b + a.d * b.d;
    
    temp.tx = a.tx * b.a + a.ty * b.c + b.tx;
    
    temp.ty = a.tx * b.b + a.ty *b.d + b.ty;
    
    return temp;
}

- (void)displayCoord {
    
    CGPoint point = _pointView.center;
    
    point = pointMinusPoint(point, _origCenter);

    point = CGPointApplyAffineTransform(point, _testView.transform);
    
    point = pointAddPoint(point, _origCenter);
    
    point = pointAddPoint(point, _origTopLeft);
    
    NSLog(@"%d, %d", (int)point.x, (int)point.y);
    
    CGPoint offset = pointMinusPoint(_orig, point);
    
    _testView.transform = CGAffineTransformMake(_testView.transform.a, _testView.transform.b, _testView.transform.c, _testView.transform.d, _testView.transform.tx + offset.x, _testView.transform.ty + offset.y);
    
//    CGAffineTransform rotate = CGAffineTransformInvert(_pointView.transform);
//    
//    _testView.transform = matrixMultiplyMatrix(rotate, _testView.transform);
    
//    CGAffineTransform xxx = CGAffineTransformTranslate(CGAffineTransformIdentity, offset.x, offset.y);
//    
//    xxx = matrixMultiplyMatrix(xxx, _testView.transform);
    
//    [_ibCoorLabel setText:[NSString stringWithFormat:@"%d, %d", (int)point.x, (int)point.y]];
//    
//    _testView.transform = trans;
}

@end
