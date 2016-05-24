//
//  SVGImageViewController.m
//  CollectiveView
//
//  Created by ky on 16/5/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SVGImageViewController.h"
#import "JAMSVGImageView.h"
#import "JAMSVGImage.h"
#import <Foundation/Foundation.h>

@interface SVGImageViewController ()

@property (nonatomic, retain) IBOutlet UIButton *ibBtnScale;
@property (nonatomic, retain) JAMSVGImageView *imageView;
@property (nonatomic, retain) JAMSVGImage *image;

@end

@implementation SVGImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _image = [JAMSVGImage imageNamed:@"svg"];
    
    _imageView = [[JAMSVGImageView alloc] initWithSVGImage:_image];
    
    [self.view addSubview:_imageView];
    
    [self.view bringSubviewToFront:_ibBtnScale];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:pan];
    
    CGRect bounds = _imageView.bounds;
    
//    _imageView.bounds = CGRectMake(0, 0, bounds.size.width * 6, bounds.size.height * 6);
    
    [_imageView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)handlePan:(UIPanGestureRecognizer*)pan {
    
    CGPoint translationPoint = [pan translationInView:_imageView];
    
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, translationPoint.x, translationPoint.y);
    
    [pan setTranslation:CGPointZero inView:_imageView];
}

- (IBAction)onScaleBtnClick:(id)sender {
    
//    _imageView.transform = CGAffineTransformScale(_imageView.transform, 1.2, 1.2);
    
    CGRect bounds = _imageView.bounds;
    
    _imageView.bounds = CGRectMake(0, 0, bounds.size.width * 1.1, bounds.size.height * 1.1);
    
    [_imageView setNeedsDisplay];
}

@end
