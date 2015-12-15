//
//  GCGiftCollectCell.m
//  CollectiveView
//
//  Created by user on 15/12/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "GCGiftCollectCell.h"

@implementation GCGiftCollectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLabelValue:(NSInteger)value {
	
	[_ibLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
}

@end
