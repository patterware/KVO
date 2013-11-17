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

@interface KVOTests : XCTestCase
@property (nonatomic, getter = isPropertySet) BOOL propertySet;
@property (nonatomic) NSString *testString;
@end

@implementation KVOTests

-(void) testObserveNewValue {
    __block BOOL propertySet = self.isPropertySet;
    [self kvoWatchNewValueOnKeypath:@"propertySet" object:self callback:^(NSNumber *newValue) {
        propertySet = [newValue boolValue];
    }];
    self.propertySet = !propertySet;
    XCTAssertEqual(propertySet, self.propertySet, @"wrong value!");
    [self kvoStopWatchingKeypath:@"propertySet" onObject:self];
}

-(void) testObserverStops {
    __block BOOL propertySet = self.isPropertySet;
    @autoreleasepool {
        [self kvoWatchNewValueOnKeypath:@"propertySet" object:self callback:^(NSNumber *newValue) {
            propertySet = [newValue boolValue];
        }];
        [self kvoStopWatchingKeypath:@"propertySet" onObject:self];
    }
    self.propertySet = !propertySet;
    XCTAssertNotEqual(propertySet, self.propertySet, @"not released!");
}

-(void) testObserveWithOptions {
    self.testString = STRING1;
    __block NSUInteger callCount = 0;
    __block NSString *string = self.testString;
    [self kvoWatchKeypath:@"testString" onObject:self callback:^(NSDictionary *change) {
        callCount++;
        string = change[NSKeyValueChangeNewKey];
    } options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior];
    self.testString = STRING2;
    XCTAssertEqualObjects(string, self.testString, @"wrong string");
    XCTAssertEqual(callCount, 3u, @"wrong call count");
    [self kvoStopWatchingKeypath:@"testString" onObject:self];
}

@end
