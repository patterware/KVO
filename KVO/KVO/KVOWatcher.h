//
//  KVOWatcher.h
//  KVO
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+KVO.h"

/**
 Object used to manage block based KVO registrations. You should never need to use
 this class directly. Use the methods provided in NSObject(KVO) instead.
 @see NSObject+KVO.h
 */
@interface KVOWatcher : NSObject

/**
 Creates a watcher that will observe changes on object.keypath using the provided observing options. KVO observing will be properly cancelled on dealloc.
 
 @param keypath The keypath to observe changes on.
 @param object The object the observed keypath belongs to.
 @param callback The callback to provide the change dictionary to whenever object.keypath changes.
 @param options The key value observing options to use when registering the KVO observation.
 @returns A KVOWatcher registered to observe changes on object.keypath.
 */
+(instancetype)watcherForKeypath:(NSString *)keypath
                          object:(id)object
                        callback:(KVOKeypathChangedCallback)callback
                         options:(NSKeyValueObservingOptions)options;
@end
