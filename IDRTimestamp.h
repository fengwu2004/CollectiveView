//
//  IDRRegionDataTimeSign.h
//  IndoorunMap_Core
//
//  Created by ky on 8/13/16.
//  Copyright © 2016 yellfun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface IDRFloorTimestamp : JSONModel

@property (nonatomic, assign) long long svgTimestamp;

@property (nonatomic, assign) long long unitTimestamp;

@end

@interface IDRRegionTimestamp : JSONModel

@property (nonatomic, assign) long long offlineDataTimestamp;

@property (nonatomic, assign) long long regionDetailTimestamp;

//@property (nonatomic, retain) NSMutableDictionary<Optional> *floorTimestamp;

@end

@interface IDRRegionTestData : JSONModel

@property (nonatomic, retain) NSMutableDictionary *dicRegions;

@end