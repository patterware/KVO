//
//  NSObject+KVO.h
//  KVO
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KVOKeypathNewValueCallback)(id newValue);
typedef void(^KVOKeypathChangedCallback)(NSDictionary *change);

@interface NSObject (KVO)

-(void)kvoWatchNewValueOnKeypath:(NSString *)keypath
                          object:(id)object
                        callback:(KVOKeypathNewValueCallback)callback;

-(void)kvoWatchKeypath:(NSString *)keypath
              onObject:(id)object
              callback:(KVOKeypathChangedCallback)callback;

-(void)kvoWatchKeypath:(NSString *)keypath
              onObject:(id)object
              callback:(KVOKeypathChangedCallback)callback
               options:(NSKeyValueObservingOptions)options;

-(void)kvoStopWatchingKeypath:(NSString *)keypath
                     onObject:(id)object;

@end
