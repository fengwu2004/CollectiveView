//
//  AnimViewController.m
//  CollectiveView
//
//  Created by user on 15/12/22.
//  Copyright © 2015年 user. All rights reserved.
//

#import "AnimViewController.h"
#import "GCMessageDetailView.h"

//是否用代码写ui，需要看简易程度，如果不改变大小等等的，可以直接用autolayout，没有复杂动画的，或者需要xib中view处理自身动画的，

@interface AnimViewController ()

@property (nonatomic, retain) IBOutlet GCMessageDetailView *messagePopUp;
@property (nonatomic, strong) NSLayoutConstraint *leading;
@end

@implementation AnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewByClassName:(NSString *)className inNib:(NSString *)nibName {
	
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
	
	Class cellClass = NSClassFromString(className);
	
	for (id oneObject in nib) {
		
		if ([oneObject isMemberOfClass:cellClass]) {
			
			return oneObject;
		}
	}
	
	return nil;
}

- (IBAction)onDetailClick:(id)sender {
	
	if (!_messagePopUp) {
		
		[[NSBundle mainBundle] loadNibNamed:@"GCMessageDetailView" owner:self options:nil];
		
//		_messagePopUp = (GCMessageDetailView*)[self viewByClassName:@"GCMessageDetailView" inNib:@"GCMessageDetailView"];
		
		[_messagePopUp setMessage:@"她给你发了一条私信"];
		
		_messagePopUp.bounds = CGRectMake(0, 0, 230, 44);
		
		_messagePopUp.center = CGPointMake(-230 * 0.5, 122);
		
		[self.view addSubview:_messagePopUp];
	}
	
	[UIView animateWithDuration:0.5 animations:^{

		_messagePopUp.center = CGPointMake(230 * 0.5, 122);
	}];
	
	bool value = 2048 & 2048;
	
	NSLog(@"%d", value);
}

@end
