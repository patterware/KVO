//
//  NSObject+KVO.h
//  KVO
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Block used to receive the current keypath value when registered with kvoWatchNewValueOnKeypath.
 */
typedef void(^KVOKeypathNewValueCallback)(id newValue);

/**
 Block used to receive the change dictionary when registered with kvoWatchKeypath.
 */
typedef void(^KVOKeypathChangedCallback)(NSDictionary *change);



/**
 Adds block based KVO to NSObject.
 */
@interface NSObject (KVO)

/**
 Begin KVO observation of object.keypath, passing the current value of object.keypath to callback whenever a change occurs.
 @param keypath The keypath to observe changes on.
 @param object The object the observed keypath belongs to.
 @param callback The block to provide the current keypath value whenever the keypath value changes.
 */
-(void)kvoWatchNewValueOnKeypath:(NSString *)keypath
                          object:(id)object
                        callback:(KVOKeypathNewValueCallback)callback;

/**
 Begin KVO observation of object.keypath, passing the change dictionary to callback whenever a change occurs.
 @param keypath The keypath to observe changes on.
 @param object The object the observed keypath belongs to.
 @param callback The block to provide the change dictionary whenever the keypath value changes.
 @param options The key value observing options to use when registering the keypath observer.
 */
-(void)kvoWatchKeypath:(NSString *)keypath
              onObject:(id)object
              callback:(KVOKeypathChangedCallback)callback
               options:(NSKeyValueObservingOptions)options;

/**
 Cancels KVO observation of object.keypath.
 @param keypath The keypath to stop observing.
 @param object The object the observed keypath belongs to.
 */
-(void)kvoStopWatchingKeypath:(NSString *)keypath
                     onObject:(id)object;

@end
