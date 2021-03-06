//
//  GCGiftView.m
//  CollectiveView
//
//  Created by user on 15/12/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "GCGiftView.h"
#import "GCGiftCollectCell.h"

#define kViewHeight 260               // view 总高度
#define kScrollableHeight 216         // 可以滑动部分的高度

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface GCGiftView()

@property (nonatomic, assign) NSInteger currPage;

@end

@implementation GCGiftView

- (void)awakeFromNib {
	
	[super awakeFromNib];
	
	UINib *nib = [UINib nibWithNibName:@"GCGiftCollectCell" bundle:nil];
	
	[_ibCollectionGift registerNib:nib forCellWithReuseIdentifier:@"GCGiftCollectCell"];
	
	[_ibPage setCurrentPage:_currPage + 1];
	
	_ibPage.currentPageIndicatorTintColor = [UIColor grayColor];
	
	[self setCollectionLayout];
	
	[_ibBtnRecharge setAttributedText:[self reChargeTitle]];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recharge:)];
	
	[_ibBtnRecharge addGestureRecognizer:tap];
}


- (void)recharge:(id)sender {
	
	NSLog(@"88888888888888888888");
}

- (void)setCollectionLayout {
	
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	
	CGFloat width = (SCREEN_WIDTH - 3 * 10 - 2 * 15)/4;
	
	CGFloat height = width + 10;
	
	layout.itemSize = CGSizeMake(width, height);
	
	layout.minimumLineSpacing = 10;
	
	layout.minimumInteritemSpacing = 15;
	
	layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	CGFloat top = (kScrollableHeight - height - height - 15)/2;
	
	layout.sectionInset = UIEdgeInsetsMake(top, 15, top, 15);
	
	[_ibCollectionGift setCollectionViewLayout:layout];
	
	_ibCollectionGift.contentSize = CGSizeMake(800, 300);
}

- (NSAttributedString*)reChargeTitle {
	
	NSString *str = [NSString stringWithFormat:@"剩余金豆:%d \n购买金豆", (int)45854];
	
	NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:str];
	
	[title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, str.length - 4)];
	
	[title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(str.length - 4, 4)];
	
	return title;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	return MIN(11 - section * 8, 8);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	
	return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString * identifier = @"GCGiftCollectCell";
	
	GCGiftCollectCell *cell = (GCGiftCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	NSLog(@"选中%d", (int)(indexPath.row + 8 * indexPath.section));
	
	[cell setHighlighted:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"shouldSelectItemAtIndexPath");
	
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"shouldHighlightItemAtIndexPath");
	
	return YES;
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
	
	CGFloat width = scrollView.frame.size.width;
	
	CGFloat offset = scrollView.contentOffset.x - _currPage * width;
	
	if (offset > 0.5 * width) {
		
		++_currPage;
		
		[_ibPage setCurrentPage:_currPage + 1];
	}
	else if (offset < -0.5 * width) {
		
		--_currPage;
		
		[_ibPage setCurrentPage:_currPage + 1];
	}
}

@end
