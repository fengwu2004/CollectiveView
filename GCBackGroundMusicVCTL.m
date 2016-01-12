//
//  GCBackGroundMusicVCTL.m
//  CollectiveView
//
//  Created by user on 16/1/12.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GCBackGroundMusicVCTL.h"
#import "GCSectionHeaderView.h"
#import "Utilities.h"
#import "GCQinTingLogView.h"

typedef NS_ENUM(NSInteger, MusicType){
	
	MusicType_Pop,
	MusicType_QingGan,
	MusicType_YuLe,
	MusicType_Movie,
};

@interface GCBackGroundMusicVCTL ()<GCSectionHeaderViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) GCSectionHeaderView *sectionHeader;
@property (nonatomic, retain) IBOutlet UIScrollView *ibScrollView;
@property (nonatomic, retain) NSArray *tableViews;
@property (nonatomic, retain) NSMutableDictionary *totalDataSource;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, assign) MusicType musicType;

@end

@implementation GCBackGroundMusicVCTL

- (void)viewDidLoad {
	
  [super viewDidLoad];
	
	_sectionHeader = [[GCSectionHeaderView alloc] initWithSectionTitles:@[@"音乐", @"情感", @"娱乐", @"电影"]];
	
	_sectionHeader.frame = CGRectMake(0, 64, SCREEN_WIDTH, 34);
	
	_sectionHeader.delegate = self;
	
	[self.view addSubview:_sectionHeader];
	
	CGFloat height = SCREEN_HEIGHT - 64 - 34;
	
	UITableView *tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) style:UITableViewStyleGrouped];
	
	tableView0.delegate = self;
	
	tableView0.dataSource = self;
	
	UITableView *tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, height) style:UITableViewStyleGrouped];
	
	tableView1.delegate = self;
	
	tableView1.dataSource = self;
	
	UITableView *tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, height) style:UITableViewStyleGrouped];
	
	tableView2.delegate = self;
	
	tableView2.dataSource = self;
	
	UITableView *tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, height) style:UITableViewStyleGrouped];
	
	tableView3.delegate = self;
	
	tableView3.dataSource = self;
	
	[_ibScrollView addSubview:tableView0];
	
	[_ibScrollView addSubview:tableView1];
	
	[_ibScrollView addSubview:tableView2];
	
	[_ibScrollView addSubview:tableView3];
	
	[_ibScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 4, height)];
	
	_tableViews = @[tableView0, tableView1, tableView2, tableView3];
	
	[self test];
}

- (void)test {
	
	_totalDataSource = [[NSMutableDictionary alloc] init];
	
	_totalDataSource[@0] = @[@"魔兽", @"笑傲江湖", @"倚天屠龙记"];
	
	_totalDataSource[@1] = @[@"法制", @"囧途乐事"];
	
	_totalDataSource[@2] = @[@"素还真", @"叶小钗", @"乱世狂刀"];
	
	_totalDataSource[@3] = @[@"九龙变", @"墨世佛劫", @"墨邪录"];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	[self reloadTableView];
}

#pragma mark --GCSectionHeaderViewDelegate

- (void)sectionHeaderView:(GCSectionHeaderView *)view sectionTappedWithIndex:(NSInteger)index title:(NSString *)title {

	if (_musicType != index) {
		
		_musicType = index;
		
		[self reloadTableView];
	}
	
	CGFloat y = _ibScrollView.frame.origin.y;

	CGFloat height = _ibScrollView.frame.size.height;
	
	[_ibScrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, y, SCREEN_WIDTH, height) animated:NO];
}

- (void)reloadTableView {
	
	UITableView *tableView = _tableViews[_musicType];
	
	_dataSource = [_totalDataSource objectForKey:[NSNumber numberWithInteger:_musicType]];
	
	[tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	
	return 60;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	
	NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"GCQinTingLogView" owner:nil options:nil];
	
	for (UIView *view in array) {
		
		if ([view isMemberOfClass:[GCQinTingLogView class]]) {
			
			return view;
		}
	}
	
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [_dataSource count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	
	NSString *str = _dataSource[indexPath.row];
	
	cell.textLabel.text = str;
	
	return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (_ibScrollView != scrollView) {
		
		return;
	}
	
	[_sectionHeader sectionHeaderViewScrollViewDidScroll:scrollView];
}

- (void)dealloc {
	
	_sectionHeader.delegate = nil;
}

@end
