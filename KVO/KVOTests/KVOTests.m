//
//  KVOTests.m
//  KVOTests
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+KVO.h"

#define STRING1 @"apple"
#define STRING2 @"banana"

@interface KVOTestObject : NSObject
@property (nonatomic, getter = isPropertySet) BOOL propertySet;
@property (nonatomic) NSString *testString;
@end

@implementation KVOTestObject
@end

@interface KVOTests : XCTestCase
@end

@implementation KVOTests

-(void) testObserveNewValue {
    KVOTestObject *test = [[KVOTestObject alloc] init];
    __block BOOL propertySet = test.isPropertySet;
    [self kvoWatchNewValueOnKeypath:@"propertySet" object:test callback:^(NSNumber *newValue) {
        propertySet = [newValue boolValue];
    }];
    test.propertySet = !propertySet;
    XCTAssertEqual(propertySet, test.propertySet, @"wrong value!");
    [self kvoStopWatchingKeypath:@"propertySet" onObject:test];
}

-(void) testObserverStops {
    KVOTestObject *test = [[KVOTestObject alloc] init];
    __block BOOL propertySet = test.isPropertySet;
    @autoreleasepool {
        [self kvoWatchNewValueOnKeypath:@"propertySet" object:test callback:^(NSNumber *newValue) {
            propertySet = [newValue boolValue];
        }];
        [self kvoStopWatchingKeypath:@"propertySet" onObject:test];
    }
    test.propertySet = !propertySet;
    XCTAssertNotEqual(propertySet, test.propertySet, @"not released!");
}

-(void) testObserveWithOptions {
    KVOTestObject *test = [[KVOTestObject alloc] init];
    test.testString = STRING1;
    __block NSUInteger callCount = 0;
    __block NSString *string = test.testString;
    [self kvoWatchKeypath:@"testString" onObject:test callback:^(NSDictionary *change) {
        callCount++;
        string = change[NSKeyValueChangeNewKey];
    } options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior];
    test.testString = STRING2;
    XCTAssertEqualObjects(string, test.testString, @"wrong string");
    XCTAssertEqual(callCount, 3u, @"wrong call count");
    [self kvoStopWatchingKeypath:@"testString" onObject:test];
}

@end
