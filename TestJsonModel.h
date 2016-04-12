//
//  TestJsonModel.h
//  CollectiveView
//
//  Created by ky on 16/4/12.
//  Copyright © 2016年 user. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@protocol PointModel
@end

@interface PointModel : JSONModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, retain) NSArray *nearIndex;

@end


@interface TestJsonModel : JSONModel

@property (nonatomic, retain) NSArray *fingerPrint;
@property (nonatomic, retain) NSArray *macs;
@property (nonatomic, retain) NSArray<PointModel> *points;

@end
