//
//  GCGiftView.m
//  CollectiveView
//
//  Created by user on 15/12/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "GCGiftView.h"
#import "GCGiftCollectCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface GCGiftView()

@property (nonatomic, assign) NSInteger currPage;

@end

@implementation GCGiftView

- (void)awakeFromNib {
	
	[super awakeFromNib];
	
	UINib *nib = [UINib nibWithNibName:@"GCGiftCollectCell" bundle:nil];
	
	[_ibCollectionGift registerNib:nib forCellWithReuseIdentifier:@"GCGiftCollectCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	return 7;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	
	return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString * identifier = @"GCGiftCollectCell";
	
	GCGiftCollectCell *cell = (GCGiftCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	[cell setLabelValue:indexPath.row + indexPath.section * 10];

	NSInteger value = random() % 3;
	
	if (value == 0) {
		
		cell.backgroundColor = [UIColor redColor];
	}
	
	if (value == 1) {
		
		cell.backgroundColor = [UIColor greenColor];
	}

	if (value == 2) {
		
		cell.backgroundColor = [UIColor blueColor];
	}

	return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (![scrollView isDragging] || [scrollView isDecelerating]) {
		
		CGFloat offset = scrollView.contentOffset.x;
		
		NSLog(@"%f", offset);
	}
}

@end
