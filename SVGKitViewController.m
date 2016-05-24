//
//  SVGKitViewController.m
//  CollectiveView
//
//  Created by ky on 16/5/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SVGKitViewController.h"
#import <SVGKit/SVGKit.h>

@interface SVGKitViewController ()

@property (nonatomic, retain) IBOutlet UIButton *ibBtnScale;
@property (nonatomic, retain) SVGKImageView *imageView;
@property (nonatomic, retain) SVGKImage *image;

@end

@implementation SVGKitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _image = [SVGKImage imageNamed:@"svg.svg"];
    
    _imageView = [[SVGKFastImageView alloc] initWithSVGKImage:_image];
    
    [self.view addSubview:_imageView];
    
    [self.view bringSubviewToFront:_ibBtnScale];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer*)pan {
    
    CGPoint translationPoint = [pan translationInView:_imageView];
    
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, translationPoint.x, translationPoint.y);
    
    [pan setTranslation:CGPointZero inView:_imageView];
}

- (IBAction)onScaleBtnClick:(id)sender {
    
    //    _imageView.transform = CGAffineTransformScale(_imageView.transform, 1.2, 1.2);
    
    CGRect bounds = _imageView.bounds;
    
    _imageView.bounds = CGRectMake(0, 0, bounds.size.width * 2, bounds.size.height * 2);
    
    [_imageView setNeedsDisplay];
}

@end
