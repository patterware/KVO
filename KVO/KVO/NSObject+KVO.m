//
//  NSObject+KVO.m
//  KVO
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import "NSObject+KVO.h"
#import "KVOWatcher.h"
#import <objc/runtime.h>

@implementation NSObject (KVO)

-(void)kvoWatchNewValueOnKeypath:(NSString *)keypath
                          object:(id)object
                        callback:(KVOKeypathNewValueCallback)callback
{
    callback = [callback copy];
    [self kvoWatchKeypath:keypath
                 onObject:object
                 callback:^(NSDictionary *change) {
        callback(change[NSKeyValueChangeNewKey]);
    }];
}

-(void)kvoWatchKeypath:(NSString *)keypath
              onObject:(id)object
              callback:(KVOKeypathChangedCallback)callback
{
    [self kvoWatchKeypath:keypath
                 onObject:object
                 callback:callback
                  options:NSKeyValueObservingOptionNew];
}

-(id)kvoWatchKeypath:(NSString *)keypath
            callback:(KVOKeypathChangedCallback)callback
             options:(NSKeyValueObservingOptions)options
{
    KVOWatcher *watcher = [KVOWatcher watcherForKeypath:keypath object:self callback:callback];
    [self addObserver:watcher forKeyPath:keypath options:options context:nil];
    return watcher;
}

-(void)kvoWatchKeypath:(NSString *)keypath
              onObject:(id)object
              callback:(KVOKeypathChangedCallback)callback
               options:(NSKeyValueObservingOptions)options
{
    NSMutableDictionary *watchers = [self watchersForObject:object];
    NSAssert(!watchers[keypath], @"already watching keypath");
    id watcher = [self kvoWatchKeypath:keypath callback:callback options:options];
    watchers[keypath] = watcher;
}

-(NSMutableDictionary *)watchersForObject:(id)object
{
    NSMutableDictionary *watchers = objc_getAssociatedObject(self, (__bridge const void *)(object));
    if (!watchers) {
        watchers = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, (__bridge const void *)(object), watchers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return watchers;
}

-(void)kvoStopWatchingKeypath:(NSString *)keypath onObject:(id)object
{
    NSMutableDictionary *watchers = [self watchersForObject:object];
    [watchers removeObjectForKey:keypath];
    if (watchers.count < 1) {
        objc_setAssociatedObject(self, (__bridge const void *)(object), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
