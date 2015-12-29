//
//  CollectiveViewUITests.m
//  CollectiveViewUITests
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CollectiveViewUITests : XCTestCase

@end

@implementation CollectiveViewUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
	
	XCUIApplication *app = [[XCUIApplication alloc] init];
	[app.buttons[@"送礼物"] tap];
	
	XCUIElement *button = app.buttons[@"Button"];
	[button tap];
	
	XCUIElement *button2 = [[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"AnimView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton].element;
	[button2 tap];
	[button tap];
	[button2 tap];
	[button tap];
	[button2 tap];
	[button tap];
	[button2 tap];
	[[[[app.navigationBars[@"AnimView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
	[[[[[[[app childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:6] childrenMatchingType:XCUIElementTypeOther].element tap];
	
	
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end

